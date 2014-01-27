module SimpleForm
  module Components
    module Icons
      def icon
        return icon_class unless options[:icon].nil?
      end

      def icon_class
        template.content_tag(:i, '', class: options[:icon])
      end
    end

    module Buttons
      def button
        return button_class unless options[:button].nil?
      end

      def button_class
        btn_opts = options[:button]

        options = {
          class: "icon-#{btn_opts[:icon]} btn btn-default"
        }

        btn_opts.each do |key, value|
          next if key == :icon
          options[key] = value
        end

        template.content_tag(:button, '', options)
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icons)
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Buttons)
