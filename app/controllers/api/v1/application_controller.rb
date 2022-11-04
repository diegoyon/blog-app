class Api::V1::ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!
  
  respond_to :json

  private

    # helper method to access the current user from the token
  def current_author
    @current_author ||= Author.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end
