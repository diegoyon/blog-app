class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @author = Author.find(params[:author_id])
    @like = Like.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @author = Author.find(params[:author_id])
    @post = Post.new(post_params)
    if @post.save
      redirect_back_or_to author_path(current_author)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_back_or_to author_path(current_author), notice: 'Post was successfully deleted.' }
    end
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .with_defaults(comments_counter: 0, likes_counter: 0, author_id: current_author.id)
  end
end
