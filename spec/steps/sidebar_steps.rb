module SidebarSteps
  step 'I click on "Create Claim"' do
    expect(page).to have_link('Create Claim')
    click_link 'Create Claim'
  end

  step 'It should be selected' do
    expect(find('#sidebar li.current')).to have_content 'CREATE CLAIM'
  end
end
