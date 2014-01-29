class ClaimForm < Powertools::Reform
  model :claim

  validates_presence_of :number, :company, :carrier, :carrier_office,
    :carrier_office_adjuster

  properties [
    :request_type, :suffix, :review_type, :number, :carrier_number,
    :is_total_loss, :primary_client_contact
  ]

  # Associations
  properties [
    :company_id, :carrier_id, :carrier_office_id, :carrier_office_adjuster_id
  ]

  property :company, form: CompanyForm, model: Company
  property :carrier, form: CarrierForm, model: Carrier
  property :carrier_office, form: CarrierOfficeForm, model: CarrierOffice
  property :carrier_office_adjuster, form: CarrierAdjusterForm, model: CarrierAdjuster

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
