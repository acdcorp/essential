class CarrierOffice < ActiveRecord::Base
  include CarrierOfficePermissions

  belongs_to :carrier

  has_many :claims
  has_many :adjusters, class_name: 'CarrierAdjuster'
  has_one :address, as: :location, dependent: :destroy

  accepts_nested_attributes_for :address
end
