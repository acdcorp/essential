step "I'm logged in" do
  login :dev
  visit root_path
end
