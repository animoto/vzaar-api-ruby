module Vzaar
  module Request
    class WhoAmI < Struct.new(:conn, :options)
      def send
        conn.using_authorised_connection(url) do |xml|
          return Response::WhoAmI.new(xml).login
        end
      end

      def url
        '/api/test/whoami'
      end
    end
  end
end
