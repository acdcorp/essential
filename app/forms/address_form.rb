class AddressForm < Reform::Form
  properties [:line1, :line2, :city, :state, :zip]

  validates :line1, :city, :state, :zip, presence: true, if: ->(r) do
    r.model.location ? true : false
  end
end
