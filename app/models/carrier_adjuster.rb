class CarrierAdjuster < ActiveRecord::Base
  include CarrierAdjusterPermissions

  belongs_to :office, class_name: 'CarrierOffice'

  # Set first and last name with one string (full_name)
  def full_name=(name)
    self.first_name, self.last_name = name.split ' '
  end

  def full_name
    first_name + " " + last_name
  end
end
