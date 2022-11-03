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

  def login
    @author = Author.find_by(name: params[:name])
    if @author && @author.autenticate(author_params[:password])
      token = encode_token({ author_id: @author.id })
      render json: { author: @author, token: token }, status: :ok
    else
      render json: { error: "Invalid name or password" }, status: :unprocessable_entity
    end
  end

  private
  
  def author_params
    params.require(:author).permit(:name, :password)
  end
end