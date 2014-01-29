class Address < ActiveRecord::Base
  belongs_to :location, :polymorphic => true
end
