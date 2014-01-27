class ClaimForm < Reform::Form
  model :claim

  properties [
    :request_type, :suffix, :review_type, :number, :carrier_number,
    :is_total_loss, :primary_client_contact
  ]

  # Associations
  properties [
    :company_id, :carrier_id, :carrier_office_id
  ]

  property :company, form: CompanyForm, model: Company

  property :owner do
    properties [:first_name, :last_name]
  end

  property :carrier do
    property :name
  end

  def negotiators
    {
      acd: 'ACD',
      client: 'Client'
    }
  end
end
