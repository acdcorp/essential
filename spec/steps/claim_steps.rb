module ClaimSteps
  attr_accessor :client, :client_company, :carrier, :carrier_office

  step 'I have a client' do
    @client_company = create :client_company
    @client         = create :client_manager_user, company: client_company
    @carrier        = create :carrier
    @carrier_office = create :carrier_office, carrier: carrier
  end

  step 'I fill out all the required fields' do
    binding.pry
    claim_info
    adverse_carrier
    estimate
    vehicle
  end

  def claim_info
    within '#claim-info' do
      select 'Audit', from: 'Request Type'
      fill_in 'Suffix', with: 'some suffix'
      fill_in 'Claim Number', with: 'S123456'
      select 'No', from: 'Total Loss?'
      select client_company.name, from: 'Company'
      select 'ACD', from: 'Negotiator'
      select client.full_name, from: 'Primary Client Contact'
      select 'Auto', from: 'Review Type'
      fill_in 'Owner First Name', with: 'OFirst'
      fill_in 'Owner Last Name', with: 'OLast'
    end
  end

  def adverse_carrier
    within '#claim-adverse-carrier' do
      fill_in 'Claim Number', with: '654321'
      select carrier.name, from: 'Carrier'
      binding.pry
      click_button 'add-carrier'
    end
  end
end
