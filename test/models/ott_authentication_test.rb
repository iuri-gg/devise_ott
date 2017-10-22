require 'test_helper'

class User
  devise :ott_authentication
end

class DeviseOttTest < ActiveSupport::TestCase
  include Devise::Models::OttAuthentication

  test 'finds for ott authentication' do
    assert_equal(User.first, User.find_for_ott_authentication('random_token'))
  end

  test 'checks if ott is allowed or not' do
    assert(ott_allowed?('random_token', 'test1@example.com'))
    assert_equal(false, ott_allowed?('random_token_', 'test1@example.com'))
    assert_equal(false, ott_allowed?('random_token', 'test2@example.com'))
  end
end
