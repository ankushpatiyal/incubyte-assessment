require_relative './errors'

class StringCalculator
  DEFAULT_SPLIT_OPERATOR = %r{[\n,]}
  class << self
    def add(numbers)
      return 0 if numbers.empty?

      split_operator, numbers = extract_operator_and_number(numbers)
      raise Errors::InvalidInputError if numbers[0].match?(/[^-?\d]\z/) || numbers[-1].match?(/[^\d]\z/)

      nums_array = numbers.split(split_operator)
      nums_array.each { |val| raise Errors::InvalidInputError if val.match?(/[^-?\d]/) }
      negative_numbers = nums_array.select{ |val| val.to_i < 0 }
      raise Errors::NegativeInputError.new(negative_numbers) if negative_numbers.length > 0

      nums_array.inject(0) { |total, val| total + val.to_i }
    end

    def extract_operator_and_number(numbers)
      split_operator = split_operator(numbers)
      numbers = extract_number_string(numbers, split_operator)
      return split_operator, numbers
    end

    def split_operator(numbers)
      split_operator = DEFAULT_SPLIT_OPERATOR

      if numbers.match?(/\A\/\/(.)\n/)
        split_operator = %r{[#{numbers.match(/\A\/\/(.)\n/)[1]}]}
      end

      split_operator
    end

    def extract_number_string(numbers, split_operator)
      if split_operator != DEFAULT_SPLIT_OPERATOR
        numbers = numbers.match(/\A\/\/(.)\n(.+)/)[2]
      end

      numbers
    end
  end
end