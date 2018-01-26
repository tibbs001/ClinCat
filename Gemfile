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
gem "sidekiq"
gem "normalize-rails"
gem 'rails_12factor'
gem "pg"
gem "puma"
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

gem "jquery-rails"
gem 'font-awesome-sass'
# user registration

# Grape API
gem 'rack'
gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-chruby'
  gem "quiet_assets"
  gem "spring"
  gem "rspec-rails"
  gem 'letter_opener'
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem 'rspec-rails'
  gem 'single_test'
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
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
