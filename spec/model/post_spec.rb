require_relative '../rails_helper'

RSpec.describe Post, type: :post do
  before { @author = Author.new(name: 'diego') }
  subject { Post.create(title: 'New Post', author: @author) }

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
    author = Author.create!(name: 'diego')
    Post.create!(author:, title: 'the post')
    lastauthor = Author.last
    expect(lastauthor.posts_counter).to eq 1
  end
end
