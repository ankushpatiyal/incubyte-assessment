require_relative '../string_calculator'

describe StringCalculator do
  let!(:calculator) { StringCalculator.new }

  describe '#add' do
    context "when empty string is given" do
      it 'returns 0' do
        expect(calculator.add("")).to eq(0)
      end
    end

    context 'when only one number is given' do
      it 'returns that number' do
        expect(calculator.add("3")).to eq(3)
      end
    end

    context 'when multiple numbers are given' do
      it 'returns the sum of those numbers' do
        expect(calculator.add("3,5")).to eq(8)
      end
    end
  end
end