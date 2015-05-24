module Fyber
  class Error < StandardError

    attr_reader :api_code, :message

    def initialize(api_code, message)
      @api_code = api_code
      @message = message
    end

    def to_s
      "#{api_code}: #{message}"
    end

  end

  class NoContentError < Error; end;

  class InvalidResponseSignature < Error

    def initialize
      super("ERROR_INVALID_RESPONSE_SIGNATURE", "The response is untrustful")
    end

  end
end
