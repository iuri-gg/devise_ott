module Devise
  module Models
    module OttAuthentication
      extend ActiveSupport::Concern

      module ClassMethods
        def find_for_ott_authentication(token)
          email = DeviseOtt::Tokens.instance.email(token)
          email && where(email: email).first
        end
      end

      def ott_allowed?(token, resource_id)
        DeviseOtt::Tokens.instance.access(token, resource_id)
      end
    end
  end
end