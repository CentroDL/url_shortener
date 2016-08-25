class LinksController < ApplicationController

  # create
  def new
  end

  def create
    # check if already exists, return existing if need be
    # create and redirect to index with message
    # duplicates = Link.where
  end

  def update
  end

  def top100
  end

  private

  def link_params
    params.require(:link).permit(:target)
  end

  CODEX = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split("").zip((0..61)).to_h
  # BASE is 62 but can be trimmed to 36 if needed
  BASE = CODEX.length

  def encoded_url(id)
    digits = []

    while id > 0
      remainder = id % @@BASE
      digits << remainder
      id /= BASE
    end

    digits.reverse.map { |num| CODEX.key num }.join("")
  end

  def decoded_id(encoded_str)
    letters = encoded_str.split("").reverse
    exponents = letters.map { |letter| CODEX[letter] }
    exponents.map.with_index { |value, id| value * (BASE**id) }.reduce(:+)
  end

  def duplicate?
  end

end
