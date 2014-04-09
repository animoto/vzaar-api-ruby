module Vzaar
  module Request
    class Url
      using Vzaar

      attr_reader :url, :params, :format

      def initialize(url, format, params={})
        @url = url
        @format = format
        @params = params
      end

      def build
        base_url = url + ".#{format.to_s}"

        _params = build_params
        _params.blank? ? base_url : (base_url + "?" + _params)
      end

      private

      def build_params
        URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
      end

    end
  end
end
