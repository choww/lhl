class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :actors, through: :roles

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true

  validates_processing_of :image

  validate :image_size_validation
  validate :release_date_is_in_past

  scope :search_movie, -> (title_or_director, duration) { 
    where("(title LIKE ? OR director LIKE ?) AND runtime_in_minutes #{duration}", "%#{title_or_director}%", "%#{title_or_director}%")
   }

  def review_average
    reviews.exists? ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

  protected
    def release_date_is_in_past
      if release_date.present?
        errors.add(:release_date, "should be in the past") if release_date > Date.today
      end
    end

  private
    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end
end
