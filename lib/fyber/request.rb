require "httparty"
require "addressable/uri"

module Fyber
  class Request
    include HTTParty
    base_uri 'api.sponsorpay.com/feed/v1/'

    attr_reader :request_method, :path, :uri, :options

    # @param [Symbol] http verb
    # @param [String] path to the offer-api or full URL
    # @param [Hash<Symbol,String>] list of the http params
    def initialize(request_method, path, options = {})
      @uri = ::Addressable::URI.parse(path.start_with?('http') ? path : self.class.base_uri + path)
      @path = uri.path
      @options = default_format(options)
      @request_method = request_method
    end

    # @return [HTTParty::Response] http response from the performed action
    def perform
      options_key = request_method == :get ? :query : :form
      self.class.public_send(request_method, uri.to_s,
        { options_key => options })
    end

    protected

      # Defines the defaul format as json if is not defiend on the params
      # @param see #initialize
      def default_format(options)
        { format: "json" }.merge(options)
      end

  end
end
