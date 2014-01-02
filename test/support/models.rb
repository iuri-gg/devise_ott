class User < ActiveRecord::Base
end

class Admin < User
  devise :ott_authentication
end
