require 'spec_helper'

feature 'Claims', :js do
  after { take_screenshot 'debug', full: true }

  context 'Creating' do
    let(:client_manager) { create(:client_manager_user, company: client_company) }
    let(:client_company) { create(:client_company) }

    before do
      login :acd_manager
      visit root_path

      # Create a client manager with company
      client_manager

      click_link 'Create Claim'
    end

    it 'should allow ACD staff to visit the create claim page' do
      expect(current_path).to eq new_claim_path
    end

    it 'should populate primary client contact based on the company selected' do
      # Claim Info
      within '#claim-info' do
        select 'Audit', from: 'Request Type'
        fill_in 'Suffix', with: 'some suffix'
        fill_in 'Claim Number', with: 'S123456'
        select 'No', from: 'Total Loss?'
        select client_company.name, from: 'Company'
        select 'ACD', from: 'Negotiator'
        select client_manager.full_name, from: 'Primary Client Contact'
        select 'Auto', from: 'Review Type'
        fill_in 'Owner First Name', with: 'OFirst'
        fill_in 'Owner Last Name', with: 'OLast'
      end

      # Adverse Carrier
      within '#claim-adverse-carrier' do
        fill_in 'Claim Number', with: 'AC123456'
      end
    end

    it 'should populate the company address based on the company select'
    it 'should redirect you to the claim once created'
  end
end
