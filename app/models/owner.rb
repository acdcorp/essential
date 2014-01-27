class Owner < ActiveRecord::Base
  include OwnerPermissions

  belongs_to :claim
end
