class User < ActiveRecord::Base
  has_secure_password
 
  has_many :reviews, dependent: :destroy
 
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create
  
  def reviewed?(movie)
    Review.where(user_id: id, movie_id: movie.id).exists?
  end
end
