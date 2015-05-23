require "spec_helper"

module Fyber
  describe Request do
    let(:path)           { '/offers' }
    let(:request_method) { :get      }
    let(:params) do
      {
        appid:      157,
        device_id:  "2b6f0cc904d137be2e1730235f5664094b831186",
        ip:         "212.45.111.17",
        locale:     "de",
        page:       2,
        ps_time:    1312211903,
        pub0:       "campaign2",
        format:     "json"
      }
    end

    describe "#perfom" do
      let(:endpoint) do
        "http://api.sponsorpay.com/feed/v1/offers"
      end

      subject { described_class.new(request_method, path, params) }

      context "given a successful get request to offers" do
        let(:http_response) do
          double("response", code: 200)
        end

        it "receive the get method with the params" do
          expect(described_class).to receive(:get)
            .with(endpoint, {query: params}).once
          subject.perform
        end

        before do
          allow(described_class).to receive(:get).with(endpoint,
            {query: params}).and_return(http_response)
        end

        it "receive the get method with the params and return 200" do
          expect(subject.perform.code).to eql(200)
        end

      end

      context "given a bad request" do
        let(:http_response) do
          double("bad response", code: 401)
        end

        before do
          allow(described_class).to receive(:get).with(endpoint,
            {query: params}).and_return(http_response)
        end

        it "receive the get method with the params and return 200" do
          expect(subject.perform.code).to eql(401)
        end
      end

    end

    describe "#options" do

      context "given the format isnt send as a param" do
        before { params.delete(:fromat) }

        subject { described_class.new(request_method, path, params) }

        it "returns the default json format" do
          expect(subject.options[:format]).to eql("json")
        end
      end

      context "given set the format on the param list" do
        before { params.merge!({format: "xml"}) }

        subject { described_class.new(request_method, path, params) }

        it "returns the format send through params" do
          expect(subject.options[:format]).to eql("xml")
        end
      end

    end

  end
end
