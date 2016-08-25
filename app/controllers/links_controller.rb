class LinksController < ApplicationController

  before_action: :duplicate?, only: [:create]

  # create
  def new
  end

  def create
  end

  # delete
  def delete

  end

  # update
  def edit
  end

  def update

  end

  # read
  def index

  end

  def show
  end

  def top100
  end

    @@CODEX = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").zip((0..61)).to_h
  # @@BASE is 62 but can be trimmed to 36 if needed
  @@BASE = @@CODEX.length

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
