module Fyber
  class Client

    attr_reader :api_key, :appid, :device_id, :options

    # @param [Hash] options list of the required attributes to connect on the api
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      @options = options
    end

    # @param [Hash] params list of params to fetch Offers
    def offers(params = {})
      Offer.all(params.merge(options))
    end

  end

end
