class Claim < ActiveRecord::Base
  extend Enumerize

  include ClaimPermissions

  belongs_to :company
  belongs_to :carrier
  belongs_to :carrier_office
  belongs_to :carrier_office_adjuster, class_name: "CarrierAdjuster"
  belongs_to :primary_client_contact

  has_one :owner

  enumerize :request_type, in: [:audit, :excess]
  enumerize :review_type,  in: [:auto, :property]
end
