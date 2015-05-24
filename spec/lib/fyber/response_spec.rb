require "yajl"
require "spec_helper"

module Fyber
  describe Response do


    describe "#parse!" do

      context "given a bad response" do
        let(:code) { 401 }
        let(:body) do
          Yajl::Parser.parse(File.read(
            "spec/support/fixtures/invalid_hashkey_response.json")
          )
        end

        subject { described_class.new(code, body, nil) }


        it "raise an error" do
          expect { subject.parse! }.to raise_error(Fyber::Error)
        end

      end

    end

  end
end
