class CarrierOfficeForm < Reform::Form
  properties [:name, :carrier_id, :adjusters]

  validates :name, presence: true

  property :address, form: AddressForm, model: Address

  #TODO: Validate uniqueness of name per office id
end
