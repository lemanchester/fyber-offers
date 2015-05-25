module Fyber
  class Client

    attr_reader :api_key, :appid, :device_id, :options

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      @options = options
    end

    def offers(params = {})
      Offer.all(params.merge(options))
    end

  end

end
