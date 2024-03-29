# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem "jbuilder"
gem "jsbundling-rails"
gem "kaminari"
gem "pg", "~> 1.1"
gem "puma"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
# gem "redis", "~> 4.0"
# gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development do
  gem "annotate"
  gem "bullet"
  gem "rubocop", require: false
  gem "rubocop-rails_config"
  gem "web-console"
end

group :test do
  gem "shoulda-matchers", "~> 6.0"
  gem "simplecov", require: false
end

group :development, :test do
  gem "brakeman"
  gem "bundler-audit"
  gem "debug", platforms: %i[ mri windows ]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry", "~> 0.14.2"
  gem "rspec-rails", "~> 6.1.0"
end
