module Vzaar
  class Connection
    using Vzaar

    SERVER = "vzaar.com".freeze
    attr_reader :application_token, :force_http, :login, :options, :server

    def initialize(options)
      @options = options
      @application_token = options[:application_token]
      @force_http = options[:force_http]
      @login = options[:login]
    end

    def using_authorised_connection(url, opts={}, &block)
      using_connection(url, opts.merge(authenticated: true), &block)
    end

    def using_public_connection(url, opts={}, &block)
      using_connection(url, opts, &block)
    end

    def using_connection(url, opts={}, &block)
      connection = opts[:authenticated] ? authorised_connection : public_connection
      response = nil
#      url = Vzaar::Request::Url.new(url, opts[:params]).build

      case opts[:http_verb] || Http::GET
      when Http::GET
        response = connection.get(url)
        yield handle_response(response) if block_given?
      when Http::DELETE
        response = connection.delete(url)
        handle_response(response)
      when Http::POST
        response = connection.post(url, opts[:data], content_type(opts[:format]))
        yield handle_response(response) if block_given?
      when Http::PUT
        response = connection.put(url, opts[:data], content_type(opts[:format]))
        handle_response(response)
      else
        handle_exception :invalid_http_verb
      end
      response
    end

    def server
      @server ||= sanitized_url.blank? ? self.class::SERVER : sanitized_url
    end

    private

    def content_type(_type='xml')
      { 'Content-Type' => 'application/#{_type}' }
    end

    def sanitized_url
      @sanitized_url ||= options[:server].gsub(/(http|https)\:\/\//, "") if options[:server]
    end

    def consumer(authorised = false)
      OAuth::Consumer.new '', '', { :site => "#{protocol(authorised)}://#{server}" }
    end

    def protocol(authorised)
      return 'http' if force_http
      authorised ? 'https' : 'http'
    end

    def authorised_connection
      @authorised_connection ||= OAuth::AccessToken.new consumer(true), login, application_token
    end

    def public_connection
      @public_connection ||= OAuth::AccessToken.new consumer, '', ''
    end

    def handle_response(response)
      Response::Handler.handle_response(response)
    end

    def handle_exception(type, custom_message = '')
      Response::Handler.handle_exception(type, custom_message)
    end

  end
end
