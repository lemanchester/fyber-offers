require "httparty"
require "addressable/uri"

module Fyber
  class Request
    include HTTParty

    attr_reader :request_method, :path, :uri, :options

    # @param [Symbol] http verb
    # @param [String] path to the offer-api or full URL
    # @param [Hash<Symbol,String>] list of the http params
    def initialize(request_method, path, options = {})
      @options = default_format(options)
      @uri = URI.new(path, @options[:format])
      @path = uri.path
      @request_method = request_method
    end

    # @return [HTTParty::Response] http response from the performed action
    def perform!
      options_key = request_method == :get ? :query : :form
      resp = self.class.public_send(request_method, uri.to_s,{ options_key => options })
      Response.new(resp.code, resp.body, resp.parsed_response,
        resp.headers).validate!
    end

    protected

      # Defines the defaul format as json if is not defiend on the params
      # @param see #initialize
      def default_format(options)
        { format: "json" }.merge(options)
      end

  end
end
