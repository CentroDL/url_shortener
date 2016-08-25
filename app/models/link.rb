class Link < ApplicationRecord

  @@CODEX = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").zip((0..61)).to_h
  @@BASE = 36

  def encode_url
    id = self.id
    digits = []

    while id > 0
      remainder = id % @@BASE
      digits << remainder
      id /= @@BASE
    end

    digits.reverse.map { |num| @@CODEX.key num }.join("")
  end

  def self.decode_url(encoded_str)
    letters = encoded_str.split("").reverse
    exponents = letters.map { |letter| @@CODEX[letter] }
    exponents.map.with_index { |value, id| value * (@@BASE**id) }.reduce(:+)
  end

  def duplicate?
  end

end
