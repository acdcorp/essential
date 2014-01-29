class Vehicle < ActiveRecord::Base
  include VehiclePermissions

  belongs_to :claim
  has_one :owner, through: :claim
end
