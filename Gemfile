source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.rc1'

# Specify your gem's dependencies in essential.gemspec

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.4.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.0'

gem 'sass-rails', '~> 4.0.1'
gem 'compass-rails', '~> 1.1.3'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0', require: false
end

group :staging, :production do
# Rails 4 requires a gem rails_12factor in order to configure your application logs to be visible via heroku logs and to serve static assets.
  gem 'rails_12factor'
  gem 'heroku_rails_deflate'
  gem 'rack-cache'
  gem 'kgio' #recommended by heroku for faster IO with rack cache
end

group :development, :test do
  gem 'meta_request'
  gem 'rspec-rails', '~> 3.0.0.beta1'

  gem "better_errors", '~> 1.1.0'
  gem 'binding_of_caller', '~> 0.7.2'

  gem 'awesome_print', '~> 1.2.0', require: 'awesome_print'
  gem 'thin', '~> 1.6.1'
  gem 'spring', '~> 1.1.0'
  gem 'spring-commands-rspec', '~> 1.0.1'
  # replace erb files with haml: rake haml:replace_erbs
  # gem "erb2haml", '~> 0.1.5'
  gem 'factory_girl_rails', '>= 4.2.1'
  gem 'pry', '~> 0.9.12.6'
  gem 'pry-rescue', '~> 1.4.0'
  gem 'pry-stack_explorer'
  gem 'faker', '~> 1.2.0'
  gem 'require_reloader', '~> 0.2.0'
  gem 'bullet', '~> 4.7.1'
  gem 'uniform_notifier', '~> 1.4.0'
  # javascript console (Safari/Webkit browsers or Firefox w/Firebug installed)
  # UniformNotifier.console = true

  # # rails logger
  # UniformNotifier.rails_logger = true
end

group :test do
  gem 'poltergeist', '~> 1.5.0'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'capybara', '~> 2.2.1'
  gem 'capybara-firebug', '~> 2.0.0'
  gem 'turnip', github: 'cj/turnip'
  gem 'webmock', '~> 1.17.2'
end

gem 'unicorn', '~> 4.8.2'
gem 'devise', '~> 3.2.2'
gem 'devise_invitable', '~> 1.3.3'
gem 'haml', '~> 4.1.0.beta.1'
gem 'protector', '~> 0.7.4'
gem 'enumerize', '~> 0.7.0'
gem 'turbolinks', '~> 2.2.1'
gem 'jquery-turbolinks', '~> 2.0.1'
gem 'turbolinks-redirect', '~> 0.0.1'
gem 'cells', '~> 3.9.1'
gem 'apotomo', github: 'apotonick/apotomo'
gem 'reform', '~> 0.2.4'
gem 'exception_notification', '~> 4.0.1'
gem 'simple_form', '~> 3.0.1'
gem 'mab', '~> 0.0.3'
gem 'scoped_search', '~> 2.6.1'
gem 'chronic', github: 'mojombo/chronic'

### THEME ###
gem 'therubyracer', '~> 0.12.1'
gem 'font-awesome-rails', '~> 4.0.3.1'
gem 'bootstrap-sass', '~> 3.1.0.2'
gem 'momentjs-rails', '~> 2.5.0'
gem 'bootstrap3-datetimepicker-rails', '~> 2.1.30'
