class Api::V1::PostsController < Api::V1::ApplicationController
  def index
    author = Author.find(params[:author_id])
    render json: author.posts
  end

  def show
    post = Post.find(params[:id])
    render json: post.comments
  end
end
