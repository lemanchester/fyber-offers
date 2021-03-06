require "spec_helper"

module Fyber
  describe Request do
    let(:path)           { 'offers' }
    let(:request_method) { :get     }
    let(:api_key)        { "232323" }
    let(:params) do
      {
        appid:      157,
        device_id:  "2b6f0cc904d137be2e1730235f5664094b831186",
        ip:         "212.45.111.17",
        locale:     "de",
        page:       2,
        ps_time:    1312211903,
        pub0:       "campaign2",
        format:     "json",
        timestamp:  1432592537
      }
    end
    let(:hashkey) { "c06f9231477ac002c2539732f6b5ce75dd6795b2" }
    let(:query) do
      { query: params.merge(hashkey: hashkey) }
    end

    subject { described_class.new(request_method, path, api_key, params) }


    describe "#perfom!" do
      let(:endpoint) do
        URI.new("offers", "json").to_s
      end

      context "given a successful get request to offers" do
        let(:http_response) do
          double("response", code: 200, body: "", parsed_response: {}, headers: {})
        end

        before do
          allow(Time).to receive_message_chain("now.to_i") { params[:timestamp] }
          allow_any_instance_of(Response).to receive(:validate!)
        end

        it "receive the get method with the params" do
          expect(described_class).to receive(:get)
            .with(endpoint, query).once.and_return(http_response)
          subject.perform!
        end

      end

      context "given a bad request" do
        let(:http_response) do
          double("bad response", code: 401, body: "", parsed_response: {}, headers: {})
        end

        before do
          allow(described_class).to receive(:get).with(endpoint,
            query).and_return(http_response)
        end

        it "raise an error" do
          expect { subject.perform! }.to raise_error(Fyber::Error)
        end
      end

    end

    describe "#options" do

      context "given the format isnt send as a param" do
        before { params.delete(:fromat) }

        it "returns the default json format" do
          expect(subject.options[:format]).to eql("json")
        end
      end

      context "given set the format on the param list" do
        before { params.merge!({format: "xml"}) }

        it "returns the format send through params" do
          expect(subject.options[:format]).to eql("xml")
        end
      end

      context "ginve the params it should set the hashkey" do

        it "returns the format send through params" do
          expect(subject.options[:hashkey]).to eql(hashkey)
        end

      end

    end

  end
end
