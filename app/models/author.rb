class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  # enum role: %i[user admin]

  def self.authenticate(email, password)
    author = Author.find_for_authentication(email:)
    author&.valid_password?(password) ? author : nil
  end

  def three_recent_posts
    posts.includes(%i[likes comments]).order('created_at DESC').first(3)
  end
end
