require "yajl"
require "spec_helper"

module Fyber
  describe Response do
    let(:headers) do
      { 'X-Sponsorpay-Response-Signature' => "123" }
    end
    subject { described_class.new(code, raw_body, parsed_body, headers) }

    describe "#parse!" do

      context "given a bad response" do
        let(:code) { 401 }
        let(:raw_body) do
          File.read("spec/support/fixtures/invalid_hashkey_response.json")
        end
        let(:parsed_body) do
          Yajl::Parser.parse(raw_body)
        end

        it "raise an error" do
          expect { subject.parse! }.to raise_error(Fyber::Error)
        end
      end

      context "given a good response without content" do
        let(:code) { 200 }
        let(:raw_body) do
          File.read("spec/support/fixtures/no_content.json")
        end
        let(:parsed_body) do
          Yajl::Parser.parse(raw_body)
        end

        before do
          allow(Encrypt).to receive(:generate).and_return("123")
        end

        it "raise an error" do
          expect { subject.parse! }.to raise_error(Fyber::NoContentError)
        end
      end

      context "given a success but unstrustful response" do
        let(:code) { 200 }
        let(:raw_body) do
          File.read("spec/support/fixtures/no_content.json")
        end
        let(:parsed_body) do
          Yajl::Parser.parse(raw_body)
        end

        it "raise an error" do
          expect { subject.parse! }.to raise_error(Fyber::InvalidResponseSignature)
        end
      end

    end

  end
end
