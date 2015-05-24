require "yajl"
require "spec_helper"

module Fyber
  describe Response do

    subject { described_class.new(code, raw_body, parsed_body, headers) }

    describe "#parse!" do

      context "given a bad response" do
        let(:code) { 401 }
        let(:headers) { nil }
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
        let(:headers) { nil }

        it "raise an error" do
          expect { subject.parse! }.to raise_error(Fyber::NoContentError)
        end
      end

    end

  end
end
