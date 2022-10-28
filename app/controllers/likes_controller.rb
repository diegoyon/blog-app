class LikesController < ApplicationController
  def create
    @post = Post.find_by(id: params[:post_id])
    @like = Like.new(
      post_id: @post.id,
      author_id: current_user.id
    )
    redirect_to author_posts_path(current_user)
    flash[:notice] = 'Already liked' unless @like.save
  end
end
