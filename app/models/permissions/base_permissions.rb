module BasePermissions
  extend ActiveSupport::Concern

  included do
    protect do |user, model|
      next unless user
      role_name = user.role.name

      if %w(admin system acd_manager).include? role_name
        # Need to remember to add things here if you add them to
        # check_generic_permissions
        can :index
        can :read
        can :create
        can :update
        can :destroy unless role_name == :system
      end

      if @model.column_names.include?('deleted_at')
        scope { where("#{model_name.to_s.underscore.pluralize}.deleted_at IS NULL") }
      end
    end
  end
end
