class AddressForm < Reform::Form
  properties [:line1, :line2, :city, :state, :zip]

  validates :line1, :city, :state, :zip, presence: true
end
