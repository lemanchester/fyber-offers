module Fyber
  class Response

    attr_reader :code, :body, :headers

    def initialize(code, body, headers)
      @code = code
      @body = body
      @headers = headers
    end

    def parse!
      raise_error if code != 200
    end

    def raise_error
      raise Error.new(body["code"], body["message"])
    end

  end
end
