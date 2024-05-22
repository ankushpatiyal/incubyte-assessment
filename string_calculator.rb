class StringCalculator
  def add(numbers)
    numbers.strip!
    return 0 if numbers.empty?

    raise Errors::InvalidInput if numbers[-1].match?(/[^\d]\z/)

    if numbers.match?(/\A\/\/(.)\n/)
      return numbers.split(%r{[#{numbers.match(/\A\/\/(.)\n/)[1]}]}).inject(0) {|total, val| total + val.to_i}
    end

    numbers.split(/[\n,]/).inject(0) { |total, val| total + val.to_i }
  end
end