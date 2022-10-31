require 'rails_helper'

RSpec.describe 'Author show page', type: :system do
  before(:each) do
    @author1 = Author.create!(name: 'Mumenya',
                              photo: 'https://picsum.photos/200',
                              bio: 'Pilot from Venus', posts_counter: 0)
    @author2 = Author.create!(name: 'Diego',
                              photo: 'https://picsum.photos/200',
                              bio: 'Engineer from Guatemala', posts_counter: 0)
    Post.create!(author: @author2, title: 'Post 1', text: 'text Post 1', comments_counter: 0, likes_counter: 0)
    Post.create!(author: @author2, title: 'Post 2', text: 'text Post 2', comments_counter: 0, likes_counter: 0)
    Post.create!(author: @author2, title: 'Post 3', text: 'text Post 3', comments_counter: 0, likes_counter: 0)
    
                              visit author_path(@author2)
  end
  describe 'show page' do
    it 'see the user\'s profile picture.' do
      visit author_path(@author2)
      image = page('img')
      expect(image.src).to eq('https://picsum.photos/200')
    end
    it 'see the user\'s username' do
      visit author_path(@author2)
      expect(page).to have_content('Diego')
    end
    it 'see the number of posts the user has written.' do
      visit author_path(@author2)
      expect(page).to have_content('Number of posts: 3')
    end
    it 'see the user\'s bio' do
      visit author_path(@author2)
      expect(page).to have_content('Engineer from Guatemala')
    end
    it 'see the user\'s first 3 posts.' do
      visit author_path(@author2)
      posts = page.all('.author-post')
      expect(posts.count).to eq(3)
    end

    it 'see a button that lets me view all of a user\'s posts.' do
      visit author_path(@author2)
      button = page.find('button')
      expect(button.value).to eq('See All Posts')
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      visit author_path(@author2)
      click_on('Post 1')
      expect(page).to have_content('Write a comment...')
    end

    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      visit author_path(@author2)
      click_on('See All Posts')
      posts = page.all('.author-post')
      expect(posts.count).to eq(Author.posts.all.count)
    end
  end
end
