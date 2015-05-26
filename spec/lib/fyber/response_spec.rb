require "spec_helper"

module Fyber
  describe Response do
    let(:headers) do
      { 'X-Sponsorpay-Response-Signature' => "123" }
    end
    let(:api_key) { "31b2cea19ffe6e0840dc7d3973c45bf77a7010b8" }

    subject { described_class.new(api_key, code, raw_body, parsed_body, headers) }

    describe "#validate!" do
      let(:parsed_body) { parse(raw_body) }

      context "given a bad response" do
        let(:code)        { 401 }
        let(:raw_body)    { raw("invalid_hashkey_response.json") }

        it "raise an error" do
          expect { subject.validate! }.to raise_error(Fyber::Error)
        end
      end

      context "given a good response without content" do
        let(:code)        { 200 }
        let(:raw_body)    { raw("no_content.json") }

        before do
          allow(Encrypt).to receive(:generate).and_return("123")
        end

        it "raise an error" do
          expect { subject.validate! }.to raise_error(Fyber::NoContentError)
        end
      end

      context "given a success but unstrustful response" do
        let(:code)        { 200 }
        let(:raw_body)    { raw("no_content.json") }


        it "raise an error" do
          expect { subject.validate! }.to raise_error(Fyber::InvalidResponseSignature)
        end
      end

      context "given a successful response with content" do
        let(:code)        { 200 }
        let(:raw_body)    { raw("offers_response.json") }

        before do
          allow(Encrypt).to receive(:generate).and_return("123")
        end

        it "returns itself" do
          expect(subject.validate!).to be_a(Fyber::Response)
        end

        it "returns itself with parsed body" do
          expect(subject.validate!.parsed_body).to eql(parsed_body)
        end

      end

    end

  end
end
