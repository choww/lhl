class User < ActiveRecord::Base
  has_many :songs
  has_many :reviews
  validates :name, presence: true
  validates :password, presence: true,
                       length: { in: 6..15 }

end
