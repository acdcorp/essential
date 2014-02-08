Essential::Nav.config do
  list = [
    {
      title: 'Create Claim',
      path: Rails.application.routes.url_helpers.new_claim_path,
      icon_class: 'plus',
      permission: current_user.role.in_group?(:acd)
    }
  ]

  #used for customizing individual menu options
  list.each do |item|
  end
end
