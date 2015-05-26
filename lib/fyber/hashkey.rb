module Fyber
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
