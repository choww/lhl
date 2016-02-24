class Song < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :votes

  validates :title, :author, presence: true
  validates :url, allow_blank: true,
                  format: { 
                    with: /\A(http[s]?:\/\/)([\w]+\.)*[a-z]+\/?[\w]*\z/i,
                    message: "should start with 'http://...'" }

  def song_added_date
    created_at.strftime("%b %d, %Y @ %H: %M")  
  end

  def reviewed?(user)
    Review.where(song_id: id, user_id: user.id).exists? 
  end
  
  def total_votes
    upvotes = votes.where(category: 'up').count
    downvotes = votes.where(category: 'down').count
    upvotes - downvotes
  end
end
