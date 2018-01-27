source "https://rubygems.org"

ruby "2.4.1"

gem 'libv8', '3.16.14.3'
gem 'faraday_middleware-aws-signers-v4'
gem "faraday"
gem 'rails', github: 'rails/rails', branch: '4-2-stable'
gem "rack-timeout"
gem "autoprefixer-rails"
gem "flutie"
gem "high_voltage"
gem 'appsignal', '~> 2.3'
gem "normalize-rails"
gem 'rails_12factor'
gem "pg"
gem 'rubyzip'
gem "recipient_interceptor"
gem "sass-rails"
gem "title"
gem "uglifier"
gem "jbuilder"
gem 'rest-client'
gem 'enumerize'
gem 'bulk_insert'
gem 'activerecord-import'
gem 'roo', '~> 2.4.0'
gem 'string-similarity'

# user registration

gem 'rack'
gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-chruby'
  gem "quiet_assets"
  gem 'letter_opener'
  gem "rack-mini-profiler", require: false
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "pry-byebug"
  gem "pry-rails"
end

group :test do
  gem "rspec-rails"
  gem 'single_test'
  gem "factory_girl_rails"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  gem "vcr"
end
