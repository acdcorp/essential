module Reform
  class Form
    include Hooks
    # include Reform::Form::ActiveRecord
    include Reform::Form::ActiveModel
    include Reform::Form::ActiveModel::FormBuilderMethods

    property :id

    attr_accessor :params

    define_hooks :before_create, :after_create, :before_update, :after_update,
      :before_save, :after_save

    def initialize(model = false)
      if model.kind_of? ::ActiveRecord::Base
        @model  = model
        @fields = setup_fields(@model)
      else
        @model  = self.class.model_name.singular.classify.constantize.new
        @fields = model ? Fields.new(model.keys, model) : setup_fields(@model)
      end
    end

    module ValidateMethods # TODO: introduce Base module.
      def validates? params = {}
        validate(params)
      end

      def validates params = {}
        validate(params)
      end

      def validate(params)
        params = params.with_indifferent_access
        # here it would be cool to have a validator object containing the validation rules representer-like and then pass it the formed model.
        from_hash(params)

        is_valid = true
        is_valid &= valid?
        is_valid &= model.valid?
        errors.merge!(model.errors)
        is_valid &= validate_for @fields, params, is_valid
        is_valid
      end

    private

      def validate_for fields, params, is_valid
        fields.to_h.each do |column, form|
          if params && form.respond_to?('valid?')
            # lets save the data to the nested form
            if (nested_params = params[column])
              nested_params = Hash[nested_params.map { |k, v| [k.gsub(/_attributes/, '').to_sym, v] }]

              current_params = nested_params.reject { |key, value| value.kind_of?(Hash) ? true : false }

              if current_params.any?
                unless current_params.length == 1 && current_params.first.first == :id
                  form.from_hash params[column]
                  is_valid &= form.valid?
                  errors.merge!(form.errors, column)

                  is_valid &= form.model.valid?
                  errors.merge!(form.model.errors, column)
                end
              else
                is_valid &= validate_for form.send(:fields), nested_params, is_valid
              end
            end
          end
        end

        is_valid
      end
    end

    def save_as current_user, &block
      form = self

      save do |data, nested|
        form.params = OpenStruct.new nested

        nested_id = false

        if nested_id = form.params.id
          form.run_hook :before_update
        else
          form.run_hook :before_create
        end

        form.run_hook :before_save

        block.call if block

        input_representer = mapper.new(self).extend(Sync::InputRepresenter)
        model.attributes  = append_attributes(input_representer.to_hash)
        add_creator_and_updater_for model, current_user, form.params

        model.save!

        form.id = model.id unless form.id

        if nested_id
          form.run_hook :after_update
        else
          form.run_hook :after_create
        end

        form.run_hook :after_save
      end
    end

    def append_attributes params
      params.clone.each do |key, value|
        if value.kind_of? Hash
          new_attributes = append_attributes(params[key])
          unless key.include? '_attributes'
            params["#{key}_attributes"] = new_attributes unless new_attributes.empty?
            params.delete key
          end
        end
      end

      params
    end

    def add_creator_and_updater_for(model, current_user = nil, current_params = @params)
      model.attributes.each do |name, value|
        if (name == "creator_id" && model.new_record?) || name == "updater_id"
          id = current_user.try(:id) || ENV["SYSTEM_USER_ID"]
          model.set_unrestricted_attribute(name, id)

          next
        end

        if name.end_with?("_id")
          name_without_id   = name[0..-4]
          associated_model  = model.try(name_without_id)

          if associated_model.kind_of? ::ActiveRecord::Base
            new_current_params = current_params[name_without_id]

            if new_current_params.kind_of? Hash
              add_creator_and_updater_for associated_model, current_user, new_current_params
            end
          end
        end
      end
    end

    class << self
      def reflect_on_association field
        Object::const_get(model_name.to_s.classify).reflect_on_association field
      end
    end

  private

    module Setup
      module Representer
      private
        def setup_nested_forms
          nested_forms do |attr, model|
            form_class = attr.options[:form]

            attr.options.merge!(
              :getter   => lambda do |*|
                nested_model  = send(attr.getter) || attr.options[:model].try(:new) # decorated.hit # TODO: use bin.get

                if attr.options[:form_collection]
                  Forms.new(nested_model.collect { |mdl| form_class.new(mdl)})
                else
                  form_class.new(nested_model)
                end
              end,
              :instance => false, # that's how we make it non-typed?.
            )
          end
        end
      end
    end
  end
end
