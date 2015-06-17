class ArticlesController < ApplicationController
  before_action :set_magazine

  def index
    @articles = @magazine.articles.page(params[:page])
  end

  def show
    @article = @magazine.articles.find(params[:id])
  end

  private

  def set_magazine
    @magazine = Magazine.find(params[:magazine_id])
  end
end
