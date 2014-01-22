FactoryGirl.define do
  factory :company do
    name 'Test Company'
  end

  factory :client_company, parent: :company do
    name 'Client Company'
  end
end
