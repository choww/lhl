class Song < ActiveRecord::Base
  validates :title, :author, presence: true
  validates :url, allow_blank: true,
                  format: { 
                    with: /\A(http[s]?:\/\/)[\w]+\.[a-z]+\/?[\w]*\z/i,
                    message: "should start with 'http://...'" }
end
