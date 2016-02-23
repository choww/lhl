class Song < ActiveRecord::Base
  belongs_to :user

  validates :title, :author, presence: true
  validates :url, allow_blank: true,
                  format: { 
                    with: /\A(http[s]?:\/\/)([\w]+\.)*[a-z]+\/?[\w]*\z/i,
                    message: "should start with 'http://...'" }

  def song_added_date
    created_at.strftime("%b %d, %Y @ %H: %M")  
  end

  def upvote
    self.increment(:votes)
    self.save
  end
end
