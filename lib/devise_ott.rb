require 'devise'
require_relative 'devise_ott/version'
require_relative 'devise_ott/tokens'
require_relative 'devise_ott/models'
require_relative 'devise_ott/strategies'

module Devise
  # Ott redis host
  # defaults to localhost
  mattr_accessor :ott_redis_host
  @@ott_redis_host = 'localhost'
end

module DeviseOtt
end

Warden::Strategies.add(:ott_authentication, DeviseOtt::Strategies::OttAuthentication)
Devise.add_module :ott_authentication, :strategy => true, :model => 'devise_ott/models/ott_authentication'