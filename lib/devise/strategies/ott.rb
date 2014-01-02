module Devise
  module Strategies
    class Ott < Devise::Strategies::Authenticatable
      def valid?
        super || valid_for_ott_auth?
      end

      def authenticate!
        ott_token = params[:ott_token]

        return fail! unless mapping.to.respond_to?(:find_for_ott_authentication) # Dont try to authenticate if module is not included

        resource = mapping.to.find_for_ott_authentication(ott_token)

        return fail! unless resource

        if validate(resource){ resource.ott_allowed?(ott_token, resource.email) }
          success!(resource)
        end
      end

      private
      # Ott Authenticatable can be authenticated with params in any controller and any verb.
      def valid_params_request?
        true
      end

      # Do not use remember_me behavior with ott token.
      def remember_me?
        false
      end

      # Check if this is strategy is valid for ott authentication by:
      #
      #   * If the ott token exists;
      #
      def valid_for_ott_auth?
        params[:ott_token].present?
      end
    end
  end
end
