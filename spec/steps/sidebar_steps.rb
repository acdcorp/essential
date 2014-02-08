module SidebarSteps
  step 'I click on "Create Claim"' do
    expect(page).to have_link('Create Claim')
    click_link 'Create Claim'
  end

  step 'It should be selected' do
    expect(find('#sidebar ul.nav-sidebar li.active')).to have_content 'Create Claim'
  end
end
