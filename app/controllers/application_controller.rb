class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_author!
  protect_from_forgery with: :null_session
  def current_ability
    @current_ability ||= Ability.new(current_author)
  end

  def login
    @author = Author.find_by(name: params[:name])
    if @author && @author.autenticate(author_params[:password])
      token = encode_token({ author_id: @author.id })
      render json: { author: @author, confirmation_token: token }, status: :ok
    else
      render json: { error: "Invalid name or password" }, status: :unprocessable_entity
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up, keys: %i[name posts_counter])
  end
end
