class ClaimForm < Reform::Form
  model :claim

  validates_presence_of :number, :appraisal_author, :estimate_written_on,
    :type_of_loss, :point_of_impact, :review_type

  validates :deductible, numericality: true, presence: true

  property :negotiator, empty: true

  properties [
    :id, :request_type, :suffix, :review_type, :number, :carrier_number,
    :is_total_loss, :primary_client_contact_id, :appraisal_author,
    :estimate_written_on, :type_of_loss, :point_of_impact,
    :deductible
  ]

  # Associations
  validates_presence_of :company_id, :carrier_id, :carrier_office_id,
    :carrier_office_adjuster_id, :primary_client_contact_id

  properties [
    :company_id, :carrier_id, :carrier_office_id, :carrier_office_adjuster_id,
    :primary_client_contact_id
  ]

  property :company, form: CompanyForm, model: Company
  property :carrier, form: CarrierForm, model: Carrier
  property :carrier_office, form: CarrierOfficeForm, model: CarrierOffice
  property :carrier_office_adjuster, form: CarrierAdjusterForm, model: CarrierAdjuster
  property :vehicle, form: VehicleForm, model: Vehicle

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
