module Fyber
  class Response

    attr_reader :code, :raw_body, :parsed_body, :headers

    def initialize(code, raw_body, parsed_body, headers)
      @code        = code
      @raw_body    = raw_body
      @parsed_body = parsed_body
      @headers     = headers
    end

    def parse!
      raise_error(Error) if code != 200
      raise InvalidResponseSignature.new unless valid?
      raise_error(NoContentError) if parsed_body["code"] == "NO_CONTENT"
    end

    protected

    def valid?
      headers['X-Sponsorpay-Response-Signature'] == Encrypt.generate(raw_body)
    end

    def raise_error(error_class)
      raise error_class.new(parsed_body["code"], parsed_body["message"])
    end

  end
end
