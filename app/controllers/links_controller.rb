class LinksController < ApplicationController

  def create
    # check if already exists, return existing if need be
    # create and redirect to index with message
    duplicates = Link.where target: link_params[:target]

    link = duplicates.empty? ? Link.create(link_params) : duplicates.first

    redirect_to root_path, notice: encoded_url(link.id)
  end

  # TODO(dennis): test that duplicates give you correct links
  # TODO(dennis): increment count
  # TODO(dennis): decide on better location for encoding/decoding functions
  # TODO(dennis): top100 view
  # TODO(dennis): style
  # TODO(dennis): add http:// validation to urls on input

  def redirector
    link = Link.find(decoded_id(params[:code])) or not_found

    link.views += 1
    link.save
    redirect_to link.target, status: 301
  end

  def update
  end

  def top100
    @top_100_links = Link.limit(100).order('views desc')
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
      remainder = id % BASE
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
