class Api::V1::AuthorsController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create]

  def index
    authors = Author.all
    render json: authors
  end

  def show
    author = Author.find(params[:id])
    render json: author
  end

  def create
    author = Author.new(email: author_params[:email], password: author_params[:password], name: author_params[:name])

    client_app = Doorkeeper::Application.find_by(uid: params[:client_id])

    return render(json: { error: 'Invalid client ID' }, status: 403) unless client_app

    if author.save
      # create access token for the author, so the author won't need to login again after registration
      access_token = Doorkeeper::AccessToken.create(
        resource_owner_id: author.id,
        application_id: client_app.id,
        refresh_token: generate_refresh_token,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        scopes: ''
      )

      # return json containing access token and refresh token
      # so that author won't need to call login API right after registration
      render(json: {
               author: {
                 id: author.id,
                 email: author.email,
                 name: author.name,
                 access_token: access_token.token,
                 token_type: 'bearer',
                 expires_in: access_token.expires_in,
                 refresh_token: access_token.refresh_token,
                 created_at: access_token.created_at.to_time.to_i
               }
             })
    else
      render(json: { error: author.errors.full_messages }, status: 422)
    end
  end

  private

  def author_params
    params.permit(:email, :password, :name)
  end

  def generate_refresh_token
    loop do
      # generate a random token string and return it,
      # unless there is already another token with the same string
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end
end
