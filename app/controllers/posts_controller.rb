class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:author_id])
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end
