class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @author = Author.find(params[:author_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_back_or_to author_path(current_author)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_back_or_to author_path(current_author), notice: 'Post was successfully deleted.' }
    end
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .with_defaults(author_id: current_author.id)
  end
end
