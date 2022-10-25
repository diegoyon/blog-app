require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it "returns a 200 OK status" do
      get "/authors/9/posts"
      expect(response).to have_http_status(:ok)
    end

    it "checks if the correct themplate was rendered" do
      get "/authors/9/posts"
      expect(response).to render_template(:index)
    end

    it "checks if the response body includes correct placeholder text" do
      get "/authors/9/posts"
      expect(response.body).to include("HERE IS THE LIST OF POSTS FOR A GIVEN AUTHOR")
    end
  end
end
