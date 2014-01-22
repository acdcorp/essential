require 'spec_helper'

feature 'Sidebar', :js do
  after { take_screenshot 'debug' }

  context 'ACD Staff' do
    before do
      login :acd_manager
      visit root_path
    end


    it 'should have create claim and be selected when clicked' do
      within '#sidebar' do
        expect(page).to have_link('Create Claim')
        click_link 'Create Claim'
        expect(find('#sidebar li.current')).to have_content 'CREATE CLAIM'
      end
    end
  end
end
