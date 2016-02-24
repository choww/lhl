class User < ActiveRecord::Base
  has_many :songs
  has_many :reviews
  has_one :vote, through: :songs

  validates :name, presence: true
  validates :password, presence: true,
                       length: { in: 6..15 }
  
  def can_vote?(song, category)
    Vote.where(song_id: song.id, user_id: id, category: category).empty?
  end

  def create_or_update_vote(song)
    Vote.where(song_id: song.id, user_id: id).first || Vote.create(user_id: id, song_id: song.id)
  end
  
  def upvote(song)
    vote = create_or_update_vote(song)
    vote.update_attribute(:category, 'up')
  end

  def downvote(song)
    vote = create_or_update_vote(song)
    vote.update_attribute(:category, 'down')
  end
end
