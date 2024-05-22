module Errors
  class InvalidInput < StandardError
    DEFAULT_MESSAGE = 'Invalid Input'
    
    def initialize(msg=DEFAULT_MESSAGE)
      super
    end
  end
end