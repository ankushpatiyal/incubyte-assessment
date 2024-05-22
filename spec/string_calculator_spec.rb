require_relative '../string_calculator'

describe StringCalculator do
  let!(:calculator) { StringCalculator }

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
        expect { calculator.add("3\n5,6,\n") }.to raise_error(Errors::InvalidInputError)
      end
    end

    context 'when there is any character in the string except separators that is not number' do
      it 'raises invalid input error' do
        expect { calculator.add("3\n5s,6,\n") }.to raise_error(Errors::InvalidInputError)
      end
    end

    context 'when there is a different delimeter provided' do
      it 'returns the sum of numbers after separating them on the basis of new delimeter' do
        expect(calculator.add("//;\n2;8;3")).to be(13)
      end
    end

    context 'when there are negative numbers in the input with custom delimiters' do
      it 'raise negative input error' do
        expect {calculator.add("//;\n-2;8;3")}.to raise_error(Errors::NegativeInputError)
      end
    end

    context 'when there are negative numbers in the input' do
      it 'raise negative input error' do
        expect {calculator.add("2,-8,3")}.to raise_error(Errors::NegativeInputError)
      end
    end
  end

  describe '#split_operator' do
    context 'when custom delimeter is given' do
      it 'returns the custom delimeter regex' do
        expect(StringCalculator.split_operator("//;\n2;8;3")).to eq(%r{[;]})
      end
    end

    context 'if no delimeter is given' do
      it 'returns default delimeter regex' do
        expect(StringCalculator.split_operator("2,8,3")).to eq(%r{[\n,]})
      end
    end
  end

  describe '#extract_number_string' do
    context 'when custom delimeter is given' do
      it 'returns string the number string without delimeter syntax' do
        expect(StringCalculator.extract_number_string("//;\n2;8;3", %r{[;]})).to eq("2;8;3")
      end
    end

    context 'when no custom delimeter is given' do
      it 'returns string the as it is' do
        expect(StringCalculator.extract_number_string("2,8\n3", StringCalculator::DEFAULT_SPLIT_OPERATOR)).to eq("2,8\n3")
      end
    end
  end
end