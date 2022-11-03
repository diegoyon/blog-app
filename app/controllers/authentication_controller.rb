# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def login
    @author = Author.find_by_email(params[:email])
    if @author&.authenticate(params[:password])
      token = jwt_encode(author_id: @author.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
