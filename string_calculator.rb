# frozen_string_literal: true

class StringCalculator
  DEFAULT_SPLIT_OPERATOR = /[\n,]/
  CUSTOM_REGEX_SPLIT_OPERATOR = /\A\/\/(.)\n(.+)/
  EXCEPT_NUMBER_REGEX = /[^\d]/
  EXCEPT_NUMBER_OR_NEGATIVE_SIGN_REGEX = /[^-?\d]/

  class << self
    def add(numbers)
      return 0 if numbers.empty?

      split_operator, numbers = extract_operator_and_number(numbers.strip)
      nums_array = get_numbers(numbers, split_operator)
      validate_all(numbers, nums_array)

      total(nums_array)
    end

    private

    def split_operator(numbers)
      return /#{numbers.match(CUSTOM_REGEX_SPLIT_OPERATOR)[1]}/ if numbers.match?(CUSTOM_REGEX_SPLIT_OPERATOR)

      DEFAULT_SPLIT_OPERATOR
    end

    def extract_number_string(numbers, split_operator)
      return numbers.match(CUSTOM_REGEX_SPLIT_OPERATOR)[2] if split_operator != DEFAULT_SPLIT_OPERATOR

      numbers
    end

    def extract_operator_and_number(numbers)
      split_operator = split_operator(numbers)
      numbers = extract_number_string(numbers, split_operator)
      [split_operator, numbers]
    end

    def get_numbers(numbers, split_operator)
      numbers.split(split_operator)
    end

    def first_and_last_character_invalid?(numbers)
      numbers[0].match?(EXCEPT_NUMBER_OR_NEGATIVE_SIGN_REGEX) || numbers[-1].match?(EXCEPT_NUMBER_REGEX)
    end

    def invalid_number_exists?(numbers)
      numbers.any? { |val| val.match?(EXCEPT_NUMBER_OR_NEGATIVE_SIGN_REGEX) || val.empty? }
    end

    def get_all_negative_numbers(numbers)
      numbers.select { |val| val.to_i.negative? }
    end

    def validate_all(numbers, nums_array)
      raise Errors::InvalidInputError if first_and_last_character_invalid?(numbers) || invalid_number_exists?(nums_array)

      negative_numbers = get_all_negative_numbers(nums_array)
      raise Errors::NegativeInputError, negative_numbers unless negative_numbers.empty?
    end

    def total(numbers)
      numbers.inject(0) { |total, val| total + val.to_i }
    end
  end
end
