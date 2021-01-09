class CreateSkis < ActiveRecord::Migration[6.0]
  def change
    create_table :skis do |t|
      t.string :brand
      t.string :model
      t.boolean :skate
      t.boolean :classic
      t.integer :size

      t.timestamps
    end
  end
end
