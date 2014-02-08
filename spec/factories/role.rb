FactoryGirl.define do
  factory :role do
    name :dev
    creator_id Rails.application.secrets.system_user_id
    updater_id Rails.application.secrets.system_user_id
  end
end
