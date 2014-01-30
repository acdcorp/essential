class Vehicle < ActiveRecord::Base
  include VehiclePermissions

  belongs_to :claim
  has_one :owner, through: :claim

  before_create do
    self.model  = model_name
  end
end
