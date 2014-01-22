Powertools::Nav.config do
  list = [
    { title: 'Create Claim', path: new_claim_path, icon_class: 'icon-plus', permission: current_user.role.in_group?(:acd) },
  ]

  #used for customizing individual menu options
  list.each do |item|
  end
end
