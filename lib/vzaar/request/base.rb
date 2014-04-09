module Vzaar
  module Request
    class Base < Struct.new(:conn, :opts)
      using Vzaar

      protected

      def base_url
        raise "not implemented"
      end

      def options
        @options ||= opts.symb_keys
      end

      def format
        @format ||= options[:format] || "xml"
      end

      def format_suffix
        format
      end

      def user_options
        { format: options[:format] }
      end

      def url
        @url ||= Url.new(base_url, format_suffix, options[:params]).build
      end
    end
  end
end
