module Vzaar
  module Request
    class Url < Struct.new(:url, :format, :params)
      using Vzaar

      def build
        _params = build_params
        _params.blank? ? base_url : (base_url + "?" + _params)
      end

      private

      def base_url
        @base_url ||= format.blank? ? url : url + ".#{format.to_s}"
      end

      def build_params
        URI.escape((params || {}).collect{|k,v| "#{k}=#{v}"}.join('&'))
      end

    end
  end
end
