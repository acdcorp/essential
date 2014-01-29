class Carrier < ActiveRecord::Base
  include CarrierPermissions

  has_many :claims
  has_many :offices, class_name: 'CarrierOffice'
end
