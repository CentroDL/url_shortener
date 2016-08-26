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
    @data = {
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [
        {
            label: "My First dataset",
            backgroundColor: "rgba(220,220,220,0.2)",
            borderColor: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81, 56, 55, 40]
        },
        {
            label: "My Second dataset",
            backgroundColor: "rgba(151,187,205,0.2)",
            borderColor: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 86, 27, 90]
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
