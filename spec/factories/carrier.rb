FactoryGirl.define do
  factory :carrier do
    name 'Test Carrier'
    creator_id Rails.application.secrets.system_user_id
    updater_id Rails.application.secrets.system_user_id
  end
end
