class Link < ApplicationRecord

  @@CODEX = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").zip((0..61)).to_h
  # @@BASE is 62 but can be trimmed to 36 if needed
  @@BASE = @@CODEX.length

  before_save :trim, :add_protocol

  def encoded_url
    id = self.id
    digits = []

    while id > 0
      remainder = id % @@BASE
      digits << remainder
      id /= @@BASE
    end

    digits.reverse.map { |num| @@CODEX.key num }.join("")
  end

  def self.decode_id(encoded_str)
    letters = encoded_str.split("").reverse
    exponents = letters.map { |letter| @@CODEX[letter] }
    exponents.map.with_index { |value, id| value * (@@BASE**id) }.reduce(:+)
  end

  private

  def trim
    self.target.strip!
  end

  def add_protocol
    if( !self.target.start_with?("http://", "https://") )
      self.target = "http://" + self.target
    end
  end

end
