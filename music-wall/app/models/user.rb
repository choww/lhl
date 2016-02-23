class User < ActiveRecord::Base
  has_many :songs
  validates :name, presence: true
  validates :password, presence: true,
                       length: { in: 6..15 }

end
