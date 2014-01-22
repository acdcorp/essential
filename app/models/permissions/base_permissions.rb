module BasePermissions
  extend ActiveSupport::Concern

  included do
    protect do |user, model|
      role_name = user.role.name

      if %w(admin dev acd_manager acd_staff).include? role_name
        can :read, :index

        can :read
        can :create
        can :update
        can :destroy if role_name == :acd_manager
      end

      if @model.column_names.include?('deleted_at') and not %(admin dev).include?(role_name) and @model.model_name.to_s != 'PtHistory'
        if not user.with_deleted
          scope { where("#{model_name.to_s.underscore.pluralize}.deleted_at IS NULL") }
        end
      end

    end
  end
end
