FactoryGirl.define do
  sequence :email_sequence do |n|
    "#{n}"
  end

  sequence :email do |n|
    "email#{n}@acdcorp.com"
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email
    password "pass"
    password_confirmation "pass"
    creator_id Rails.application.secrets.system_user_id
    updater_id Rails.application.secrets.system_user_id
  end

  if Rails.env.test?
    # Create a shortcut for each role
    Role.names.each do |role_name|
      factory :"#{role_name}_user", parent: :user do
        email { "#{role_name}#{generate(:email_sequence)}@acdcorp.com" }
        role { Role.where(name: role_name).first or create(:role, name: role_name) }
      end
    end
  end
end
