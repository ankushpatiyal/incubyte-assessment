class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    numbers.split(",").inject(0) { |total, val| total + val.to_i }
  end
end