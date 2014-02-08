class ClaimForm < Reform::Form
  model :claim

  validates_presence_of :number, :appraisal_author, :estimate_written_on,
    :type_of_loss, :point_of_impact, :review_type, :negotiator

  validates :deductible, numericality: true, presence: true

  properties [
    :id, :request_type, :suffix, :review_type, :number, :carrier_number,
    :is_total_loss, :primary_client_contact_id, :appraisal_author,
    :estimate_written_on, :type_of_loss, :point_of_impact,
    :deductible, :negotiator
  ]

  # Associations
  validates_presence_of :company_id, :carrier_id, :carrier_office_id,
    :carrier_office_adjuster_id, :primary_client_contact_id

  properties [
    :company_id, :carrier_id, :carrier_office_id, :carrier_office_adjuster_id,
    :primary_client_contact_id
  ]

  property :vehicle, form: VehicleForm, model: Vehicle

  property :owner do
    properties [:first_name, :last_name]
  end
end
