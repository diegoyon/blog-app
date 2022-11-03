class AuthorsController < ApplicationController
  def create
    @author = Author.create(author_params)
    if @author.valid?
      token = encode_token({ author_id: @author.id })
      render json: { author: @author, token: token }, status: :ok
    else
      render json: { error: "Invalid name or password" }, status: :unprocessable_entity
    end
  end

  private
  
  def author_params
    params.permit(:name, :password)
  end
end