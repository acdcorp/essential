module ClaimSteps
  attr_accessor :client, :client_company

  step 'I have a client' do
    @client_company = create :client_company
    @client         = create :client_manager_user, company: client_company
  end

  step 'I fill out all the required fields' do
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
end
