require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  describe 'GET /index' do
    it 'returns a 200 OK status' do
      get '/authors'
      expect(response).to have_http_status(:ok)
    end

    it 'checks if the correct themplate was rendered' do
      get '/authors'
      expect(response).to render_template(:index)
    end

    it 'checks if the response body includes correct placeholder text' do
      get '/authors'
      expect(response.body).to include('HERE IS THE LIST OF AUTHORS')
    end
  end

  describe 'GET /show' do
    it 'returns a 200 OK status' do
      get '/authors/9'
      expect(response).to have_http_status(:ok)
    end

    it 'checks if the correct themplate was rendered' do
      get '/authors/9'
      expect(response).to render_template(:show)
    end

    it 'checks if the response body includes correct placeholder text' do
      get '/authors/9'
      expect(response.body).to include('HERE IS THE DETAILS OF A GIVEN AUTHOR')
    end
  end
end
