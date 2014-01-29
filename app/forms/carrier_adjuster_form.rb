class CarrierAdjusterForm < Reform::Form
  properties [
    :first_name, :last_name, :business_phone, :business_phone_ext,
    :carrier_office_id
  ]

  validates :first_name, :last_name, :business_phone, presence: true
  #TODO: Validate uniqueness of name per office id
end
