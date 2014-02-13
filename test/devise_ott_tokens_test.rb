require 'test_helper'

class DeviseOttTest < ActiveSupport::TestCase
  test 'redis is present' do
    class DeviseOtt::Tokens;attr_reader :redis;end

    assert_equal('PONG', DeviseOtt::Tokens.instance.redis.ping)
  end

  test 'redis shuts down after finalize' do
    class DeviseOtt::Tokens;class << self;attr_accessor :redis;end;end
    DeviseOtt::Tokens.redis = DeviseOtt::Tokens.instance.redis

    assert_nothing_raised { DeviseOtt::Tokens.finalize }
    assert_equal('OK', DeviseOtt::Tokens.finalize)
  end

  test 'redis revokes' do
    assert_equal(1, DeviseOtt::Tokens.instance.revoke('random_token'))
    DeviseOtt::Tokens.instance.register('random_token', 'test1@example.com', 1040, 100100)
  end

  test 'accesses token for a given email if allowed' do
    assert_equal(true, DeviseOtt::Tokens.instance.access('random_token', 'test1@example.com'))
  end

  test 'deny token access if not allowed' do
    assert_equal(false, DeviseOtt::Tokens.instance.access('random_token', 'test2@example.com'))
  end

  test 'returns correct email if allowed' do
    DeviseOtt::Tokens.instance.access('random_token', 'test1@example.com')
    assert_equal('test1@example.com', DeviseOtt::Tokens.instance.email('random_token'))
  end

  test 'denies email access unless allowed' do
    DeviseOtt::Tokens.instance.access('random_token', 'test1@example.com')
    assert_equal(nil, DeviseOtt::Tokens.instance.email('random_token_'))
  end

  test 'loads config if allowed' do
    class DeviseOtt::Tokens;public :load_config;end
    assert_not_nil(DeviseOtt::Tokens.instance.load_config('random_token'))
  end

  test 'does not load config if disallowed' do
    class DeviseOtt::Tokens;public :load_config;end
    assert_equal(nil, DeviseOtt::Tokens.instance.load_config('random_token_'))
  end

  test 'returns ttl if allowed' do
    class DeviseOtt::Tokens;public :ttl;end
    ttl = DeviseOtt::Tokens.instance.ttl('random_token')
    assert_send([ttl, :is_a?, Numeric])
    assert_operator(ttl, :>, 0)
  end

  test 'does not return ttl unless allowed' do
    class DeviseOtt::Tokens;public :ttl;end
    refute_operator(DeviseOtt::Tokens.instance.ttl('random_token_'), :>, 0)
  end
end