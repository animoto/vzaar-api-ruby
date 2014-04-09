module Vzaar::Request
  class WhoAmI < Base

    def send
      conn.using_authorised_connection(url) do |xml|
        return Response::WhoAmI.new(xml).login
      end
    end

    private

    def base_url
      '/api/test/whoami'
    end

    def format_suffix
      nil
    end
  end
end
