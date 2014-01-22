module AuthSteps
  attr_accessor :current_user

  step 'I login as :name' do |role_name|
    @current_user = create(:"#{role_name}_user")

    visit login_path

    fill_in 'user_email', with: current_user.email
    fill_in 'user_password', with: 'pass'

    click_button 'Sign in'
  end

  step 'I should be at /claims' do
    expect(current_path).to eq claims_path
  end

  step 'I visit /claims' do
    visit claims_path
  end

  step 'I should be at the /login page' do
    expect(current_path).to eq login_path
  end
end
