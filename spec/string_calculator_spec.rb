require_relative '../string_calculator'

describe StringCalculator do
  let(:calculator) { StringCalculator.new }
  describe '#add' do
    context "when empty string is given" do
      it 'returns 0' do
        expect(calculator.add("")).to eq(0)
      end
    end
  end
end