require "spec_helper"

module Fyber
  describe Hashkey do

    describe "#generate" do
      let(:api_key) { "b07a12df7d52e6c118e5d47d3f9e60135b109a1f" }
      let(:params) do
        {
          appid:      157,
          device_id:  "2b6f0cc904d137be2e1730235f5664094b831186",
          ip:         "212.45.111.17",
          locale:     "de",
          page:       2,
          ps_time:    1312211903,
          pub0:       "campaign2",
          timestamp:  1312553361,
          uid:        "player1"
        }
      end

      subject{ described_class.new(params, api_key) }

      context "given a list of params" do
        let(:expected) do
          "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186"\
          "&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2"\
          "&timestamp=1312553361&uid=player1"\
          "&b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
        end

        it "it order the params to a encrypted query string" do
          expect(subject.generate).to eql(Digest::SHA1.hexdigest(expected))
        end

      end

      context "given the list of params isn't being ordered" do
        let(:expected) do
          "&b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
          "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186"\
          "&timestamp=1312553361&uid=player1"\
          "&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2"\
        end

        it "returns a different sha1 string" do
          expect(subject.generate).not_to eql(Digest::SHA1.hexdigest(expected))
        end
      end

    end

  end
end




