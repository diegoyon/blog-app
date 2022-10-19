require_relative '../rails_helper'

RSpec.describe Comment, type: :comment do
  it 'update_comments_counter method' do
    author = Author.create!(name: 'diego', posts_counter: 0)
    post = Post.create!(author:, title: 'the post', comments_counter: 0, likes_counter: 0)
    Comment.create!(text: 'this is a comment', author:, post:)
    lastpost = Post.last
    expect(lastpost.comments_counter).to eq 1
  end
end
