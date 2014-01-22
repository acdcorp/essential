include Warden::Test::Helpers

module FeatureHelpers
  def login user_type, options = {}
    user = create :"#{user_type}_user", options
    login_as user, scope: :user
    user
  end
end
