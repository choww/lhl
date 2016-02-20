class Message < ActiveRecord::Base 
   validates :author, :content, presence: true 
   validates :url, format: { with: /\A(http[s]?:\/\/)[\w]+\.[a-z]+\z/i,
                             message: "should start with 'http://...'" },
                   allow_blank: true
end
