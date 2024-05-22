class StringCalculator
  def add(numbers)
    numbers.strip!
    return 0 if numbers.empty?

    raise Errors::InvalidInputError if numbers[-1].match?(/[^\d]\z/)

    split_operator = %r{[\n,]}

    if numbers.match?(/\A\/\/(.)\n/)
      split_operator = %r{[#{numbers.match(/\A\/\/(.)\n/)[1]}]}
    end

    negative_numbers = []
    numbers.split(split_operator).map{|val| negative_numbers << val.to_i if val.to_i < 0}
    raise Errors::NegativeInputError.new(negative_numbers) if negative_numbers.length > 0
    numbers.split(split_operator).inject(0) { |total, val| total + val.to_i }
  end
end