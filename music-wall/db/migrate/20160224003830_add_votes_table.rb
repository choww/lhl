class AddVotesTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :category
      t.belongs_to :user, index: true
      t.belongs_to :song, index: true
      t.timestamps null: false
    end
    
    remove_column :songs, :votes, :integer
  end
end
