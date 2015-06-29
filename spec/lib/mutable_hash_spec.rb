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
      string = full.inject('') do
        |str, pair| str << "#{pair.first}: #{pair.last}\n"
      end

      expect do
        subject.each { |k, v| puts "#{k}: #{v}" }
      end.to output(string).to_stdout
    end

    it_behaves_like 'Mutable'

    context 'a nested hash' do
      let(:original) do
        {
          a: 'alpha',
          b: {
            g: 'gamma',
            d: 'delta',
            e: { z: 'zeta' },
          }
        }
      end

      it 'is deeply immutable' do
        subject[:b][:e][:z] = 'zed'
        expect(subject[:b][:e][:z]).to eq 'zed'
        subject.revert!
        expect(subject[:b][:e][:z]).to eq 'zeta'
      end

      context 'once frozen' do
        it 'is still deeply immutable' do
          subject[:b][:e][:z] = 'zed'
          subject.freeze!
          subject[:b][:e][:z] = 'zee'
          subject.revert!
          expect(subject[:b][:e][:z]).to eq 'zed'   # not 'zeta', the original
        end
      end
    end
  end
end
