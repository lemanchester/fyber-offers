module Fyber
  class Response

    attr_reader :code, :raw_body, :parsed_body, :headers

    # @param [Integer] the http status code
    # @param [String]  the raw response body
    # @param [Hash<String,String>] parsed response body
    # @param [Hash<String,String>] the headers of the request
    def initialize(code, raw_body, parsed_body, headers)
      @code        = code
      @raw_body    = raw_body
      @parsed_body = parsed_body
      @headers     = headers
    end

    # @return [Response] if the response is valid return itself
    # @raise [Fyber::Error] when status code != 200
    # @raise [Fyber::InvalidResponseSignatura] when the header resp-sig don't match
    # @raise [Fyber::NoContentError] when there is no content on the body
    def validate!
      raise_error(Error) if code != 200
      raise InvalidResponseSignature.new unless valid?
      raise_error(NoContentError) if parsed_body["code"] == "NO_CONTENT"
      self
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
