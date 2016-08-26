class LinksController < ApplicationController

  def create

    new_link =  Link.new(link_params)

    if new_link.save
      redirect_to root_path, notice: new_link.encoded_url
    else
      existing_link = Link.find_by target: new_link.target
      redirect_to root_path, notice: existing_link.encoded_url
    end

  end

  def show
    @link = Link.find Link.decode_id(params[:id])

    # for chart
    views_per_day = @link.views_per_day
    @data = {
      labels: views_per_day.keys,
      datasets: [
        {
            label: "Views By Date",
            backgroundColor: "rgba(65, 210, 28, 0.2)",
            borderColor: "rgba(65, 210, 28,1)",
            data: views_per_day.values
        }
      ]
    }
  end

  def redirector
    id = Link.decode_id params[:code]
    link = Link.find(id) or not_found

    View.create link: link, ip_address: request.remote_ip

    redirect_to link.target, status: 301
  end

  def top100
    @top_100_links = Link.top100
  end

  private

  def link_params
    params.require(:link).permit(:target)
  end

end
