require "spec_helper"

module Fyber
  describe Client do
    let(:options) do
      {
        appid: 157,
        api_key: "b07a12df7d52e6c118e5d47d3f9e60135b109a1f",
        device_id: "2b6f0cc904d137be2e1730235f5664094b83",
      }
    end

    describe "#offers" do
      let(:params) do
        {
          locale: "de",
          ip: "109.235.143.113",
          offer_types: "112m",
          uid: "157",
          pub0: "player1",
          page: 1
        }
      end

      subject { described_class.new(options) }

      context "given a list of params" do

        it "call Offer.all with the right params" do
          expect(Offer).to receive(:all).with(params.merge(options)).once
          subject.offers(params)
        end

      end

      context "given params is not set" do

        it "call Offer.all with options as params" do
          expect(Offer).to receive(:all).with(options).once
          subject.offers
        end

      end

      context "given a set a new app_key by the param list" do
        let(:params) do
          {
            api_key: "9999999"
          }
        end

        it "keeps the api_key set on the initializer" do
          expect(Offer).to receive(:all).with(options).once
          subject.offers(params)
        end
      end

    end

  end
end
