class Claim < ActiveRecord::Base
  extend Enumerize

  include ClaimPermissions

  belongs_to :company
  belongs_to :carrier
  belongs_to :carrier_office
  belongs_to :carrier_office_adjuster, class_name: "CarrierAdjuster"
  belongs_to :primary_client_contact

  has_one :owner
  has_one :vehicle

  enumerize :request_type, in: [:audit, :excess]
  enumerize :review_type,  in: [:auto, :property]
  enumerize :status, in: [
    :new, :in_progress, :reviewed, :in_negotiation, :arbitration, :settled
  ]
  enumerize :appraisal_author, in: [
    :repair_shop, :insurance_adjuster, :independent_appraiser
  ]
  enumerize :type_of_loss, in: [:collision, :property_damage]
end
