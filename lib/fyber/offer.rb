require "hashie"

module Fyber
  class Offer < ::Hashie::Mash

    def self.all(params)
      resp = Request.new(:get, "offers", params).perform!
      resp.parsed_body['offers'].map do |element|
        self.new(element)
      end
    end

  end
end
