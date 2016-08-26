class ViewsController < ApplicationController

  def show
    @view = View.find params[:id]
  end

end
