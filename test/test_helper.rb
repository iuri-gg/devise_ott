# Set RAILS_ENV to test
ENV['RAILS_ENV'] = 'test'

DEVISE_ORM = (ENV['DEVISE_ORM'] || :active_record).to_sym
TEST_ROOT = File.expand_path('../', __FILE__)

require 'rails/all'
require 'devise'
require 'devise_ott'
require 'rails/test_help'
require 'minitest/rails'
require 'rails_app/config/environment'
require 'coveralls'

Coveralls.wear!

Dir[File.join(TEST_ROOT, 'support/*.rb')].each{ |f| require f }
