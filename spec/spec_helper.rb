# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/firebug/rspec'
require 'turnip/capybara'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/steps/**/*steps.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.enable_firebug
  profile["extensions.firebug.defaultPanelName"] = 'console'
  profile["extensions.firebug.showInfoTips"] = false
  Capybara::Selenium::Driver.new(app, profile: profile)
end

Capybara.register_driver :ff_remote do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.enable_firebug
  profile["extensions.firebug.defaultPanelName"] = 'console'
  profile["extensions.firebug.showInfoTips"] = false
  Capybara::Selenium::Driver.new(app, desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox(firefox_profile: profile), url: 'http://127.0.0.1:4443/wd/hub', browser: :remote)
end

if not ENV['TEST_IN_BROWSER']
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      # window_size: [1024, 768],
      window_size: [1280, 1024],
      # port: 44678,
      js_errors: true
    )
  end
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist
else
  Capybara.default_driver    = :firefox
  Capybara.javascript_driver = :firefox
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include ScreenshotHelper, type: :feature
  config.include FeatureHelpers, type: :feature

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:suite) do
    FactoryGirl.reload

    DatabaseCleaner[:active_record, {
      connection: :test
    }].strategy = :truncation, { :except => %w[schema_migrations]}
    DatabaseCleaner[:active_record, {
      connection: :test
    }].clean_with(:truncation, { :except => %w[schema_migrations]} )
  end

  config.before(:each) do
    if defined? page and page.driver.browser.respond_to? :manage
      page.driver.browser.manage.window.maximize
    end

    DatabaseCleaner[:active_record, {:connection => :test}].start
  end

  config.after(:each) do
    DatabaseCleaner[:active_record, {:connection => :test}].clean
  end
end
