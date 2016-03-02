class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :roles
  has_many :actors, through: :roles

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  
  validate :release_date_is_in_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.exists?
  end

  protected
    def release_date_is_in_past
      if release_date.present?
        errors.add(:release_date, "should be in the past") if release_date > Date.today
      end
    end
end
