require_relative '../errors'

describe Errors::InvalidInput do
  describe 'initialize' do
    context 'when no error message is given' do
      it 'returns default message' do
        error_object = Errors::InvalidInput.new
        expect(error_object.message).to be(Errors::InvalidInput::DEFAULT_MESSAGE)
      end
    end

    context 'when error message is given' do
      it 'returns that message' do
        msg = "This input is invalid"
        error_object = Errors::InvalidInput.new(msg)
        expect(error_object.message).to be(msg)
      end
    end
  end
end