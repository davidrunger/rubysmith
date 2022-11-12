# frozen_string_literal: true

ruby File.read('.ruby-version').strip

source 'https://rubygems.org'

gemspec

group :code_quality do
  gem 'git-lint', '~> 4.0'
  gem 'reek', '~> 6.1'
  gem 'runger_style', github: 'davidrunger/runger_style', require: false
  gem 'simplecov', '~> 0.21', require: false
end

group :development do
  gem 'rake', '~> 13.0'
end

group :test do
  gem 'guard-rspec', '~> 4.7', require: false
  gem 'rspec', '~> 3.11'
end

group :tools do
  gem 'amazing_print', '~> 1.4'
  gem 'debug', '~> 1.6'
end
