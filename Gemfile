source 'https://rubygems.org'

gem 'rails', '~> 5.0.2'
gem 'sprockets-rails', github: 'rails/sprockets-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'active_model_serializers', '~> 0.10.0'

gem 'stripe', require: 'stripe'
gem 'paypal-sdk-rest'
gem 'bugsnag'
gem 'countries'
gem 'fog-aws'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'rmagick', '~> 2.13.1'
gem 'omniauth'
gem 'mailgun_rails'
gem 'devise'
gem 'devise_token_auth'

gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'

# Overwrites
gem 'json', github: 'flori/json', branch: 'v1.8'

group :development, :test do
  gem 'byebug', platform: :mri

  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'stripe-ruby-mock', '~> 2.3.1', require: 'stripe_mock'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'rails_12factor'
  gem 'lograge'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
