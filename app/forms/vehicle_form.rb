class VehicleForm < Reform::Form
  properties [:year, :make, :model_name, :vin]

  validates :year, :make, :model_name, presence: true
  validates :vin, presence: true, length: { within: 17..17 }
end
