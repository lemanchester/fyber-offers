
module Fyber
  class URI

    BASE = 'http://api.sponsorpay.com/feed/v1/'

    attr_reader :uri

    # @param [String] the uri path
    # @param [String|Symbol] the format
    def initialize(path, format)
      path = set_format(path, format)
      if path.start_with?('http')
        @uri = parse(path)
      else
        @uri = parse(BASE).join(path)
      end
    end

    [:to_s, :path].each do |method|
      define_method method do
        uri.public_send(method)
      end
    end

    protected

      def set_format(path, format)
         path += ".#{format}" unless path[/.(json|xml)\z/]
      end

      def parse(path)
        ::Addressable::URI.parse(path)
      end

  end
end
