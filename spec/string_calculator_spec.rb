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

    context 'when newline is separator between numbers' do
      it 'gives sum of the numbers present' do
        expect(calculator.add("3\n5")).to eq(8)
      end
    end

    context 'when newline and comma both are treated as separators' do
      it 'gives sum of the numbers present' do
        expect(calculator.add("3\n5,6")).to eq(14)
      end
    end

    context 'when newline and comma both are treated as separators' do
      it 'gives sum of the numbers present' do
        expect(calculator.add("3\n5,6")).to eq(14)
      end
    end

    context 'when there is a character at the end of the string that is not number' do
      it 'raises invalid input error' do
        expect { calculator.add("3\n5,6,\n") }.to raise_error(Errors::InvalidInput)
      end
    end
  end
end