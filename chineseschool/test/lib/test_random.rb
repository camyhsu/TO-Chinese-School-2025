# frozen_string_literal: true

class TestRandom
  NUMERIC_CHARSET = ("0".."9").to_a

  def self.numeric(length = 5)
    Array.new(length) { NUMERIC_CHARSET.sample }.join
  end

  def self.alphanumeric(length = 7)
    SecureRandom.alphanumeric(length)
  end

  def self.integer_from_0_to_exclusive(max = 10)
    bound = max.abs.to_i
    rand(bound).to_i
  end

  def self.integer_from_a_range(range)
    return rand(range) if range.is_a? Range
    rand(range) # should not reach here -- this is a fallback
  end
end
