module Vzaar
  module Request
    class AccountType < Base
      def execute
        conn.using_public_connection(url) do |xml|
          return Response::AccountType.new(xml)
        end
      end

      private

      def base_url
        "/api/accounts/#{account_type_id}"
      end

      def account_type_id
        options[:account_type_id]
      end
    end
  end
end
