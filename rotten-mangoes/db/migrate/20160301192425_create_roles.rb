class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :actor, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
