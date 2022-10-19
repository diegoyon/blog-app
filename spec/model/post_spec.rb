require_relative '../rails_helper'

RSpec.describe Post, type: :post do
  before { Post.create(title: 'New Post', comments_counter: 0, likes_counter: 0) }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should have less than 250 characters' do
    subject.title = 'asdfasdfhjwerjlkajflasdjfljalsdfjalsdjflasjdfl;asj
    dfl;asjdflasjdflasjflasjfaksdfjlasdjfal;sdjfwoeirqwperoiualsdfalsjdflwje
    proiquweoiruoasjdfalsdfnlnvzlxcvnjl;asdkjfqpoweiruqpoweirupoasjfdlakjsf;as
    ldfkijqwieorpqweoriuoiasjfalsjdfqoweirljsflasdjfiwoerjqowerjlfjasldjflajsd'
    expect(subject).to_not be_valid
  end

  it 'comments_counter greater or equal to 0' do
    subject.comments_counter = -2
    expect(subject).to_not be_valid
  end

  it 'likes_counter greater or equal to 0' do
    subject.likes_counter = -20
    expect(subject).to_not be_valid
  end

  it 'five recent comments to be an array' do
    expect(subject.five_recent_comments).to match_array([])
  end

  it 'update_posts_counter method' do
    author = Author.create!(name: 'diego', posts_counter: 0)
    Post.create!(author:, title: 'the post', comments_counter: 0, likes_counter: 0)
    lastauthor = Author.last
    expect(lastauthor.posts_counter).to eq 1
  end
end
