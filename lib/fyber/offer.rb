require "hashie"

module Fyber
  class Offer < ::Hashie::Mash

    # @param [Hash<Symbol,Strin>] list of params
    # @return [Array<Fyber::Offer>] list of offers
    def self.all(params)
      resp = Request.new(:get, "offers", params).perform!
      resp.parsed_body['offers'].map do |element|
        self.new(element)
      end
    end

  end
end
