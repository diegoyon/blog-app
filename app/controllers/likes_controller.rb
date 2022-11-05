class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = Like.new(
      post_id: post.id,
      author_id: current_author.id
    )
    redirect_back_or_to author_posts_path(current_author)
    flash[:notice] = 'Already liked' unless like.save
  end

  def destroy
    current_author.likes.find(params[:id]).destroy
    redirect_back_or_to author_posts_path(current_author)
  end
end
