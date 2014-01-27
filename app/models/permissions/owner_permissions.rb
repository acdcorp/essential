module OwnerPermissions
  extend ActiveSupport::Concern

  included do
    include BasePermissions

    protect do |user|
      can :read                             # ... and view anything
      can :create                           # ... and create anything
      can :update                           # ... and update anything
      can :destroy                          # ... and they can delete
    end
  end
end
