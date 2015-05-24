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

      subject { described_class.all(params) }

      context "given it return a list of offers" do
        let(:params) do
          {
            uid: "157",
            pub0: "player1",
            page: 1
          }
        end
        before do
          allow_any_instance_of(Request).to receive(:perform!).and_return(response)
        end

        it { expect(subject).to be_a(Array) }

        it { expect(subject.first).to be_a(Offer) }

      end

    end

  end
end
