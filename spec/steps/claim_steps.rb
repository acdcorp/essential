module ClaimSteps
  attr_accessor :client, :client_company, :carrier, :carrier_office,
    :carrier_adjuster

  step 'I have a client' do
    @client_company = create :client_company
    @client         = create :client_manager_user, company: client_company
    @carrier        = create :carrier
    @carrier_office = create :carrier_office, carrier: carrier
    @carrier_adjuster = create :carrier_adjuster,
      office: carrier_office
    create :address, location: carrier_office
  end

  step 'I fill out all the required fields' do
    claim_info
    adverse_carrier
    estimate
    vehicle
  end

  def claim_info
    within '#claim-info-panel' do
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
    within '#adverse-carrier-panel' do
      fill_in 'Claim Number', with: '654321'

      select carrier.name, from: 'Carrier'
      select carrier_office.name, from: 'Carrier Office'
      select carrier_adjuster.full_name, from: 'Carrier Office Adjuster'
    end

    click_button 'add-carrier'
    within find(:xpath, '//body').find('.bootbox') do
      fill_in 'Name', with: 'New Carrier'
      click_button 'Add'
    end

    click_button 'add-carrier-office'
    within find(:xpath, '//body').find('.bootbox') do
      fill_in 'Name', with: 'New Carrier Office'
      fill_in 'Line1', with: 'Some Address'
      fill_in 'City', with: 'City'
      select 'California', from: 'State'
      fill_in 'Zip', { with: '90036' }, 'mask'
      click_button 'Add'
    end

    click_button 'add-carrier-adjuster'
    within find(:xpath, '//body').find('.bootbox') do
      fill_in 'First Name', with: 'New'
      fill_in 'Last Name', with: 'Adjuster'
      fill_in 'Business Phone', { with: '(555) 555 - 5555' }, 'mask'
      click_button 'Add'
    end
  end

  def estimate
    within '#estimate-panel' do
      select 'Repair Shop', from: 'Appraisal Author'
      find('#claim_estimate_written_on').click
      find(:xpath, '//body').find('div.bootstrap-datetimepicker-widget tbody tr:first-child td:last-child').click
      select 'Collision', from: 'Type Of Loss'
      fill_in 'Deductible', with: '10000'
    end
  end

  def vehicle
    within '#vehicle-panel' do
      select '2013', from: 'Year'
      fill_in 'Make', with: 'Some Make'
      fill_in 'Model', with: 'Some Model'
      fill_in 'Vin', { with: '11111111111111111' }, 'mask'
    end
  end
end
