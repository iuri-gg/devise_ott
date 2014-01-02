require_relative 'devise/models'
require_relative 'devise/strategies'

module Devise
  # Ott redis host
  # defaults to localhost
  mattr_accessor :ott_redis_host
  @@ott_redis_host = 'localhost'
end