require "spec_helper"

module Fyber
  describe Encrypt do

    subject { described_class }

    describe ".generate" do
      let(:message) { "check" }

      it { expect(subject.generate(message)).to an_instance_of(String) }

      it { expect(subject.generate(message)).not_to eql(message) }

    end
  end
end
