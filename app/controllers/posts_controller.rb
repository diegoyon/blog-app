class PostsController < ApplicationController
  def index
    @author = Author.find(params[:author_id])
    @like = Like.new
  end

  def show
    @author = Author.find(params[:author_id])
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to author_posts_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .with_defaults(comments_counter: 0, likes_counter: 0, author_id: current_user.id)
  end
end
