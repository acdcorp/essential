class VehicleForm < Reform::Form
  properties [:year, :make, :model, :vin]

  validates :year, :make, :model, presence: true
  validates :vin, presence: true, length: { within: 17..17 }
end
