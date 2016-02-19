class Message < ActiveRecord::Base
   validates :title, :author, :content, presence: true 
end
