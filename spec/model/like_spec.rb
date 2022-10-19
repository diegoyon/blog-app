require_relative '../rails_helper'

RSpec.describe Like, type: :like do
  it 'update_likes_counter method' do
    author = Author.create!(name: 'diego', posts_counter: 0)
    post = Post.create!(author:, title: 'the post', comments_counter: 0, likes_counter: 0)
    Like.create!(author:, post:)
    lastpost = Post.last
    expect(lastpost.likes_counter).to eq 1
  end
end
