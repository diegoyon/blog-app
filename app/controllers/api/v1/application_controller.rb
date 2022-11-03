class Api::V1::ApplicationController < ActionController::API
  respond_to :json

  #protect_from_forgery with: :null_session

  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end
end
