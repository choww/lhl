class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :content, presence: true
  validates :rating, presence: true,
                     numericality: { in: 1..5 }
 end
