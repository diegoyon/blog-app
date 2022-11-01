require 'rails_helper'

RSpec.describe 'Author index page', type: :feature do
  before(:each) do
    @author1 = Author.create!(name: 'Mumenya',
                              photo: 'https://picsum.photos/200',
                              bio: 'Pilot from Venus', posts_counter: 0)
    @author2 = Author.create!(name: 'Diego',
                              photo: 'https://picsum.photos/200',
                              bio: 'Engineer from Guatemala', posts_counter: 0)
    visit authors_path
  end
  describe 'index page' do
    it 'shows the right content' do
      visit authors_path
      expect(page).to have_content(@author1.name)
    end
    it 'shows the right content' do
      visit authors_path
      expect(page).to have_content(@author2.name)
    end
    it 'assigns all users to @authors' do
      visit authors_path
      expect(assigns(:authors)).to eq(Author.all)
    end
    it 'show author has image' do
      visit authors_path
      images = page.all('img')
      expect(images.count).to eq(Author.all.count)
    end
    it 'shows number of posts for user' do
      visit authors_path
      expect(page).to have_content('Number of posts: 0')
    end
    it 'redicrects to author show page' do
      visit authors_path
      click_on('Mumenya')
      expect(page).to have_content('New Post')
      # expect(current_path).to eql(author_path(@author.id))
    end
  end
end
