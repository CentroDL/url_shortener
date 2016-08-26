class LinksController < ApplicationController

  def create
    duplicates = Link.where target: link_params[:target].strip
    link = duplicates.empty? ? Link.create(link_params) : duplicates.first
    redirect_to root_path, notice: link.encoded_url
  end

  def redirector
    id = Link.decode_id params[:code]
    link = Link.find(id) or not_found

    View.create link: link, ip_address: request.remote_ip

    redirect_to link.target, status: 301
  end

  def update
  end

  def top100
    @top_100_links = Link.top100
  end

  private

  def link_params
    params.require(:link).permit(:target)
  end

end
