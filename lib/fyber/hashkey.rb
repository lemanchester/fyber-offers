module Fyber
  # Class responsable to generate the Hashkey to validate the request.
  #
  # This hash key has to be generated by the device itself and has to follow strict rules:
  #  - Get all request parameters and their values (except hashkey)
  #  - Order theses pairs alphabetically by parameter name
  #  - Concatenate all pairs using = between key and value and & between the pairs.
  #  - Concatenate the resulting string with & and the API Key handed out to you by Fyber.
  #  - Hash the whole resulting string, using SHA1.
  #  - The resulting hashkey is then appended to the request as a separate parameter.
  # Source: {http://developer.fyber.com/content/ios/offer-wall/offer-api/}
  class Hashkey < Struct.new(:options, :api_key)

    # @return [String] encrypted ordernaded query string
    def generate
      @hashkey ||= Encrypt.generate(query_string)
    end

    protected

      def query_string
        sort_params_adding_api_key.join("&")
      end

      def sort_params_adding_api_key
        symbolize_keys
        sorted_params = options.keys.sort.map{ |key| "#{key}=#{options[key]}" }
        sorted_params << api_key
      end

      def symbolize_keys
        self.options = Hash[ self.options.map { |k,v| [k.to_sym, v] } ]
      end

  end
end
