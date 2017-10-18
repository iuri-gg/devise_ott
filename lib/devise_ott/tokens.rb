require 'redis'
require 'singleton'

module DeviseOtt
  class Tokens
    include Singleton

    def initialize
      @redis ||= Redis.new(:host => Devise.ott_redis_host)
    end

    def self.finalize(*)
      @redis.quit
    end

    # register one time token for given user in redis
    # the generated token will have a field "email" in order to identify the associated user later
    def register(token, email, granted_to_email, access_count, expire)
      save_config(token, {email: email, granted_to_email: granted_to_email, access_count: access_count})
      @redis.expire(token, expire)

      token
    end

    # deletes the token
    def revoke(token)
      @redis.del(token)
    end

    # accesses token for given email if it is allowed
    def access(token, email)
      config = load_config(token)

      return false unless config
      return false unless config[:email].to_s == email.to_s
      return false unless config[:access_count] > 0

      save_config(token, config.merge(access_count: config[:access_count] - 1))

      true
    end

    # returns email for a given token
    def email(token)
      config = load_config(token)
      config && config[:email]
    end

    # returns config hash for a given token
    def granted_to_email(token)
			config = load_config(token)
			config && config[:granted_to_email]
    end

    private
    def save_config(token, hash)
      time_left = ttl(token)
      @redis.set(token, Marshal.dump(hash))
      @redis.expire(token, time_left) if time_left > 0
    end

    def load_config(token)
      if token_data = @redis.get(token)
        Marshal.load(token_data)
      end
    end

    def ttl(token)
      @redis.ttl(token)
    end
  end
end
