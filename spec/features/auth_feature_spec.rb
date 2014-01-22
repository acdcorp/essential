require 'spec_helper'

feature 'Authentication', :js do
  after { take_screenshot 'debug' }

  context 'login' do
    it 'should redirect to /claims on success for each user' do
      Role.names.each do |role_name|
        current_user = create(:"#{role_name}_user")
        visit login_path
        fill_in 'user_email', with: current_user.email
        fill_in 'user_password', with: 'pass'
        click_button 'Sign in'
        expect(current_path).to eq claims_path
        visit logout_path
      end
    end
  end

  context 'not logged in' do
    it 'should redirect to login when visiting /claims' do
      visit claims_path
      expect(current_path).to eq login_path
    end
  end
end
