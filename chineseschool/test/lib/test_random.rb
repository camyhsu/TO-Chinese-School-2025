# frozen_string_literal: true

class TestRandom
  NUMERIC_CHARSET = ("0".."9").to_a

  def self.numeric(length = 5)
    Array.new(length) { NUMERIC_CHARSET.sample }.join
  end

  def self.alphanumeric(length = 7)
    SecureRandom.alphanumeric(length)
  end
end
