require_relative '../rails_helper'

RSpec.describe Like, type: :like do
  it 'update_likes_counter method' do
    author = Author.create!(name: 'diego')
    post = Post.create!(author:, title: 'the post')
    Like.create!(author:, post:)
    lastpost = Post.last
    expect(lastpost.likes_counter).to eq 1
  end
end
