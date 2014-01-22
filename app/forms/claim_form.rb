class ClaimForm < Powertools::Form
  form_name :claim

  # Table fields
  delegate :id,
    :company_id, :request_type, :suffix, :is_total_loss, :number,
    :review_type, :carrier_number,
    to_model: :claim

  # Asccociated fields
  delegate :primary_client_contact_id, :primary_client_contact,
    :owner_id, :owner,
    to_model: :claim

  def negotiators
    {
      acd: 'ACD',
      client: 'Client'
    }
  end

  def owner
    unless claim.owner
      claim.build_owner
    end

    claim.owner
  end
end
