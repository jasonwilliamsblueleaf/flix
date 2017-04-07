class User < ApplicationRecord
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true

  validates :username, presence: true, format: /\A[A-Z0-9]+\z/i, uniqueness: { case_sensitive: false } 

  validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }

  def self.authenticate(username, password)
  	user = User.find_by(username: username)
  	user && user.authenticate(password)
  end
end
