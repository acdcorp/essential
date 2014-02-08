FactoryGirl.define do
  factory :carrier_adjuster do
    first_name 'Test'
    last_name 'Carrier Adjuster'
    creator_id Rails.application.secrets.system_user_id
    updater_id Rails.application.secrets.system_user_id
  end
end
