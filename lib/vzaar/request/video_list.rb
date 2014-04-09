module Vzaar
  module Request
    class VideoList < Base
      def send
        conn.using_connection(url, opts) do |body|
          return Response::VideoList.new(body)
        end
      end

      private

      def user_options
        super.merge authenticated: options[:authenticated]
      end

      def base_url
        "/api/#{login}/videos"
      end

      def url_params
        { page: options[:page] || 1 }
      end

      def login
        options[:login]
      end
    end
  end
end
