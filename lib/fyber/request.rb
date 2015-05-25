require "httparty"
require "addressable/uri"

module Fyber
  class Request
    include HTTParty

    attr_reader :request_method, :path, :uri, :options, :api_key

    # @param [Symbol] http verb
    # @param [String] path to the offer-api or full URL
    # @param [String] the api key
    # @param [Hash<Symbol,String>] list of the http params
    def initialize(request_method, path, api_key, options = {})
      @options        = set_hashkey(defaults(options), api_key)
      @uri            = URI.new(path, @options[:format])
      @path           = uri.path
      @api_key        = api_key
      @request_method = request_method
    end

    # @return [HTTParty::Response] http response from the performed action
    def perform!
      options_key = request_method == :get ? :query : :form
      resp = self.class.public_send(request_method, uri.to_s,{ options_key => options })
      Response.new(api_key, resp.code, resp.body, resp.parsed_response,
        resp.headers).validate!
    end

    protected

      def set_hashkey(options, api_key)
        options.merge(hashkey: Hashkey.new(options, api_key).generate)
      end

      # Defines the default format and adding timestamp
      # @param see #initialize
      def defaults(options)
        { format: "json", timestamp: Time.now.to_i }.merge(options)
      end

  end
end
