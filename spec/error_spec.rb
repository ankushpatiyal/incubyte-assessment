require_relative '../errors'

describe Errors::InvalidInputError do
  describe 'initialize' do
    context 'when no error message is given' do
      it 'returns default message' do
        error_object = Errors::InvalidInputError.new
        expect(error_object.message).to be(Errors::InvalidInputError::DEFAULT_MESSAGE)
      end
    end

    context 'when error message is given' do
      it 'returns that message' do
        msg = "This input is invalid"
        error_object = Errors::InvalidInputError.new(msg)
        expect(error_object.message).to be(msg)
      end
    end
  end
end

describe Errors::NegativeInputError do
  describe 'initialize' do
    context 'when negative numbers are given' do
      it 'returns error message with numbers' do
        error_object = Errors::NegativeInputError.new([-1,-2])
        expect(error_object.custom_error_message).to eq(error_object.message)
      end
    end
  end
end