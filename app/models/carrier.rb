class Carrier < ActiveRecord::Base
  include CarrierPermissions

  has_many :claims
end
