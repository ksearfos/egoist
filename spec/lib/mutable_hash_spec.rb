require 'spec_helper'

module Mutability
  describe MutableHash do
    subject { described_class.new(original) }
    let(:original) do
      { a: 'alpha', b: 'beta', g: 'gamma', d: 'delta', e: 'epsilon' }
    end
    let(:additional) do
      { z: 'zeta', y: 'eta', th: 'theta' }
    end
    let(:full) { original.merge additional }

    before do
      subject.merge! additional
    end

    it 'acts like a normal Hash' do
      string = full.inject('') { |str,pair| str << "#{pair.first}: #{pair.last}\n" }
      expect do
        subject.each { |k,v| puts "#{k}: #{v}" }
      end.to output(string).to_stdout
    end

    it_behaves_like 'Mutable'
  end
end
