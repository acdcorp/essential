FactoryGirl.define do
  factory :company do
    name 'Test Company'
    creator_id Rails.application.secrets.system_user_id
    updater_id Rails.application.secrets.system_user_id
  end

  factory :client_company, parent: :company do
    name 'Client Company'
  end
end
