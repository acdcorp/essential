class Company < ActiveRecord::Base
  has_many :claims
  has_many :users
end
