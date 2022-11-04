# spec/requests/blogs_spec.rb
require 'swagger_helper'

describe 'Authors API' do

  path '/authors' do

    # post 'Creates a blog' do
    #   tags 'Blogs'
    #   consumes 'application/json'
    #   parameter name: :blog, in: :body, schema: {
    #     type: :object,
    #     properties: {
    #       title: { type: :string },
    #       content: { type: :string }
    #     },
    #     required: [ 'title', 'content' ]
    #   }

    #   response '201', 'blog created' do
    #     let(:blog) { { title: 'foo', content: 'bar' } }
    #     run_test!
    #   end

    #   response '422', 'invalid request' do
    #     let(:blog) { { title: 'foo' } }
    #     run_test!
    #   end
    # end
  end

  path '/authors/{id}' do

    get 'Retrieves an author' do
      tags 'Author'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      # request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'author found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            bio: { type: :string },
            photo: { type: :string }
          },
          required: [ 'id', 'name' ]

        let(:id) { Author.create(name: 'Diego').id }
        run_test!
      end

      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end