class CarrierAdjusterForm < Reform::Form
  properties [
    :first_name, :last_name, :business_phone, :business_phone_ext
  ]

  validates :name, presence: true
  #TODO: Validate uniqueness of name per office id
end
