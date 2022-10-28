class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find_by(id: params[:id])
    @like = Like.new
  end
end
