class Link < ApplicationRecord

  @@CODEX = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").zip((0..61)).to_h

  def encode_url
    id = self.id
    digits = []

    while id > 0
      remainder = id % 62
      digits << remainder
      id /= 62
    end

    digits.reverse.map { |num| @@CODEX.key num }.join("")
  end

  def decode_url
  end

  def duplicate?
  end



end
