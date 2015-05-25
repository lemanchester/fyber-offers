require "spec_helper"

module Fyber
  describe Offer do

    describe ".all" do
      let(:raw_body) do
        File.read("spec/support/fixtures/offers_response.json")
      end
      let(:parsed_body) do
        Yajl::Parser.parse(raw_body)
      end
      let(:response) do
        Response.new(200, raw_body, parsed_body, {})
      end
      let(:params) do
        {
          uid: "157",
          pub0: "player1",
          page: 1
        }
      end

      subject { described_class }

      context "given the list of params" do
        let(:request_double) do
          double("request", perform!: response)
        end

        it "call the request with the right params" do
          expect(Request).to receive(:new).with(:get, "offers", "9999", params).and_return(request_double)
          subject.all(params.merge({ api_key: "9999" }))
        end
      end

      context "given it return a list of offers" do

        subject { described_class.all(params) }

        before do
          allow_any_instance_of(Request).to receive(:perform!).and_return(response)
        end

        it { expect(subject).to be_a(Array) }

        it { expect(subject.first).to be_a(Offer) }

      end

    end

  end
end
