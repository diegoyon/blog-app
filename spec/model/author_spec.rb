require_relative '../rails_helper'

RSpec.describe Author, type: :author do
  subject { Author.new(name: 'diego', posts_counter: 0) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter greater or equal to 0' do
    subject.posts_counter = -2
    expect(subject).to_not be_valid
  end

  it 'three latest posts to be an array' do
    expect(subject.three_recent_posts).to match_array([])
  end
end
