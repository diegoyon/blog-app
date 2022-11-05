class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_author!
  # protect_from_forgery with: :null_session

  def after_sign_in_path_for(_author)
    authors_path
  end

  def current_ability
    @current_ability ||= Ability.new(current_author)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio photo])
  end
end
