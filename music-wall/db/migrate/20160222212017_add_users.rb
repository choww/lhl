class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.timestamps null: false
    end
  
    add_reference :songs, :user, index: true
  end
end
