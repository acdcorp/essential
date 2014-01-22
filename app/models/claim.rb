class Claim < ActiveRecord::Base
  extend Enumerize

  belongs_to :company
  belongs_to :primary_client_contact

  has_one :owner

  enumerize :request_type, in: [:audit, :excess]
  enumerize :review_type,  in: [:auto, :property]
end
