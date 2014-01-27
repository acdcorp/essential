class Company < ActiveRecord::Base
  include CompanyPermissions

  has_many :claims
  has_many :users
  belongs_to :creator, class_name: 'User'
  belongs_to :updater, class_name: 'User'
  belongs_to :primary_client_contact, class_name: 'User'
end
