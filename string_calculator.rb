class StringCalculator
  DEFAULT_SPLIT_OPERATOR = %r{[\n,]}

  class << self
    def add(numbers)
      return 0 if numbers.empty?

      split_operator, numbers = extract_operator_and_number(numbers)
      nums_array = get_numbers(numbers, split_operator)
      validate_all(numbers, nums_array)

      total_sum(nums_array)
    end

    def validate_all(numbers, nums_array)
      raise Errors::InvalidInputError if first_and_last_character_invalid?(numbers)
      raise Errors::InvalidInputError if invalid_number_exists?(nums_array)

      negative_numbers = get_all_negative_numbers(nums_array)
      raise Errors::NegativeInputError.new(negative_numbers) if negative_numbers.length > 0
    end

    def invalid_number_exists?(numbers)
      numbers.any? { |val| val.match?(/[^-?\d]/) || val == "" }
    end

    def get_all_negative_numbers(numbers)
      numbers.select{ |val| val.to_i < 0 }
    end

    def total_sum(numbers)
      numbers.inject(0) { |total, val| total + val.to_i }
    end

    def extract_operator_and_number(numbers)
      split_operator = split_operator(numbers)
      numbers = extract_number_string(numbers, split_operator)
      return split_operator, numbers
    end

    def first_and_last_character_invalid?(numbers)
      numbers[0].match?(/[^-?\d]\z/) || numbers[-1].match?(/[^\d]\z/)
    end

    def get_numbers(numbers, split_operator)
      numbers.split(split_operator)
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