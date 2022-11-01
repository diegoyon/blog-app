require 'rails_helper'

RSpec.describe 'Author show page', type: :feature do
  before(:each) do
    @author1 = Author.create!(name: 'Mumenya',
                              photo: 'https://picsum.photos/200',
                              bio: 'Pilot from Venus', posts_counter: 0)
    @author2 = Author.create!(name: 'Diego',
                              photo: 'https://picsum.photos/200',
                              bio: 'Engineer from Guatemala', posts_counter: 0)
    @post1 = Post.create!(author: @author2, title: 'Post 1', text: 'text Post 1', comments_counter: 0, likes_counter: 0)
    @post2 = Post.create!(author: @author2, title: 'Post 2', text: 'text Post 2', comments_counter: 0, likes_counter: 0)
    @post3 = Post.create!(author: @author2, title: 'Post 3', text: 'text Post 3', comments_counter: 0, likes_counter: 0)
    @post4 = Post.create!(author: @author2, title: 'Post 4', text: 'text Post 4', comments_counter: 0, likes_counter: 0)

  end
  describe 'show page' do
    it 'see the user\'s profile picture.' do
      visit author_path(@author2.id)
      images = page.all('img')
      expect(images.count).to eq(1)
    end
    it 'see the user\'s username' do
      visit author_path(@author2.id)
       expect(page.find('h2', text: 'Diego')).to be_truthy
       expect(page).to have_content('Diego')
    end
    it 'see the number of posts the user has written.' do
      visit author_path(@author2.id)
      expect(page.body).to include('Posts: 4')
      expect(page).to have_content("Posts: #{@author2.posts.count}")

    end
    it 'see the user\'s bio' do
      visit author_path(@author2.id)
      expect(page.body).to have_content('Engineer from Guatemala')
      expect(page).to have_content(@author2.bio)
    end
    it 'see the user\'s first 3 posts.' do
      visit author_path(@author2)
      # posts = page.all('post-card')
      # expect(posts).to eq(3)
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
      expect(page).to have_content('Post 4')
      expect(page).not_to have_content('Post 1')
    end

    it 'see a button that lets me view all of a user\'s posts.' do
      visit author_path(@author2)
      expect(page).to have_content('See All Posts')
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      visit author_path(@author2)
      click_on('Post 2')
      expect(current_path).to eql(author_post_path(@author2, @post2))
    end

    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      visit author_path(@author2)
      click_link('See All Posts')
      expect(current_path).to eq(author_posts_path(@author2))
    end
  end
end
