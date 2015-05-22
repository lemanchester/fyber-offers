require 'digest/sha1'

module Fyber
  class Hashkey < Struct.new(:params, :api_key)

    # @return [String] encrypted ordernaded query string
    def generate
      @hashkey ||= Digest::SHA1.hexdigest(query_string)
    end

    protected

      def query_string
        sort_params_adding_api_key.join("&")
      end

      def sort_params_adding_api_key
        sorted_params = params.keys.sort.map{ |key| "#{key}=#{params[key]}" }
        sorted_params << api_key
      end

  end
end
