class StringCalculator
  def add(numbers)
    numbers.strip!
    return 0 if numbers.empty?

    raise Errors::InvalidInput if numbers[-1].match?(/[^\d]\z/)

    numbers.split(/[\n,]/).inject(0) { |total, val| total + val.to_i }
  end
end