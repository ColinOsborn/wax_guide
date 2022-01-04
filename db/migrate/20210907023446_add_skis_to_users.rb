class AddSkisToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :skis do |t|
      t.string :brand
      t.string :model
      t.boolean :skate
      t.boolean :classic
      t.integer :size
      t.string :grind
      
      t.timestamps
    end
    add_reference :skis, :user, index: true, foreign_key: true
  end
end
