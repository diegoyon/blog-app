require_relative '../rails_helper'

RSpec.describe Comment, type: :comment do
  it 'update_comments_counter method' do
    author = Author.create!(name: 'diego')
    post = Post.create!(author:, title: 'the post')
    Comment.create!(text: 'this is a comment', author:, post:)
    lastpost = Post.last
    expect(lastpost.comments_counter).to eq 1
  end
end
