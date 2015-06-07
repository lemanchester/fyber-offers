module Fyber
  # Responsable to wrap any unknow error from API
  class Error < StandardError

    attr_reader :api_code, :message

    # @param [String] api_code the string code that defines the error
    # @param [String] message the message explaning the error
    def initialize(api_code, message)
      @api_code = api_code
      @message = message
    end

    def to_s
      "#{api_code}: #{message}"
    end

  end

  # Error when there is no content on the response
  class NoContentError < Error; end;

  # Error when the response is invalid
  class InvalidResponseSignature < Error

    def initialize
      super("ERROR_INVALID_RESPONSE_SIGNATURE", "The response is untrustful")
    end

  end
end
