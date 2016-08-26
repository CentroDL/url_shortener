class Link < ApplicationRecord

  has_many :views
  before_validation :trim, :add_protocol

  validates :target, uniqueness: true

  # maps integer to base 62 string value
  @@CODEX = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").zip((0..61)).to_h
  # @@BASE is 62 due to the length of the codex but can be trimmed to 36 if needed
  @@BASE = @@CODEX.length


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

  def self.top100
    order("views_count DESC").limit(100)
  end

  private

  def trim
    self.target.strip!
    self.target.chomp! "/"
  end

  def add_protocol
    if( !self.target.start_with?("http://", "https://") )
      self.target = "http://" + self.target
    end
  end

end
