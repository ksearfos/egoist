require 'spec_helper'

module Mutability
  describe MutableArray do
    subject { described_class.new(original) }
    let(:original) { %[alpha beta gamma delta epsilon] }
    let(:additional) { %w[zeta eta theta] }
    let(:full) { original + additional }

    before do
      subject << additional
    end

    it 'acts like a normal Array' do
      expect do
        subject.each { |e| puts e }
      end.to output(all.join("\n")).to_stdout
    end

    it_behaves_like Mutable
  end
end
