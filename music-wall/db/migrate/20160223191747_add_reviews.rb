class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :song, index: true
      t.belongs_to :user, index: true
      t.text       :content
      t.timestamps null: false
    end
  end
end
