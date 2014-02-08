FactoryGirl.define do
  factory :carrier_office do
    name 'Test Carrier Office'
    creator_id Rails.application.secrets.system_user_id
    updater_id Rails.application.secrets.system_user_id
  end
end
