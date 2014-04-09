module Vzaar
  module Request
    class Signature < Base

      private

      def authenticated?
        true
      end

      def format_suffix
        nil
      end

      def base_url
        '/api/videos/signature'
      end

      def url_params
        keys = [:success_action_redirect, :include_metadata, :flash_request]
        keys.inject({}) do |h,k|
          v = options[k]
          h[k] = v if v
          h
        end
      end
    end
  end
end
