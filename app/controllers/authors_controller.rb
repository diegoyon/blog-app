class AuthorsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_author, only: [:show, :destroy]

  def index
    @authors = Author.all
    render json: @authors, status: :ok
  end

  def show
    @author = Author.find(params[:id])
    render json: @author, status: :ok
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      render json: @author, status: :created
    else
      render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
    def author_params
      params.permit(:name, :email, :password)
    end

    def set_user
      @author = Author.find(params[:id])
    end
end
