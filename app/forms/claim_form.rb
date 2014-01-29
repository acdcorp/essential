class ClaimForm < Reform::Form
  model :claim

  validates_presence_of :number, :company_id, :carrier_id, :carrier_office_id,
    :carrier_office_adjuster_id, :appraisal_author, :estimate_written_on,
    :type_of_loss, :point_of_impact

  validates :deductible, numericality: true, presence: true

  properties [
    :request_type, :suffix, :review_type, :number, :carrier_number,
    :is_total_loss, :primary_client_contact, :appraisal_author,
    :estimate_written_on, :type_of_loss, :point_of_impact,
    :deductible
  ]

  # Associations
  properties [
    :company_id, :carrier_id, :carrier_office_id, :carrier_office_adjuster_id
  ]

  property :company, form: CompanyForm, model: Company
  property :carrier, form: CarrierForm, model: Carrier
  property :carrier_office, form: CarrierOfficeForm, model: CarrierOffice
  property :carrier_office_adjuster, form: CarrierAdjusterForm, model: CarrierAdjuster
  # property :vehicle, form: VehicleForm, model: Vehicle
  property :vehicle do
    properties [:year, :make, :model, :vin]
#
#     validates :year, :make, :model, presence: true
#     validates :vin, presence: true, length: { within: 17..17 }
  end

  property :owner do
    properties [:first_name, :last_name]
  end

  def negotiators
    {
      acd: 'ACD',
      client: 'Client'
    }
  end
end
