require "spec_helper"

module Fyber
  describe URI do

    subject { described_class.new(path, format) }

    describe  "#to_s" do
      let(:path)   { "offers" }
      let(:format) { :json }

      context "given the offers path" do

        it "return the full url setting the format" do
          expect(subject.to_s).to eql("#{URI::BASE}offers.json")
        end
      end

      context "given the full http endpoint" do
        let(:path)   { "http://api.sponsorpay.com/feed/v1/user/1" }
        let(:format) { :xml }

        it "return the full url setting the format" do
          expect(subject.to_s).to eql("#{path}.xml")
        end
      end

    end

  end
end
