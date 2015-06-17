class MagazinesController < ApplicationController

  def index
    @magazines =  Magazine.page(params[:page])
  end

end
