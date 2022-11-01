class ApplicationController < ActionController::Base
  before_action :authenticate_author!
  def current_user
    Author.first
  end
end
