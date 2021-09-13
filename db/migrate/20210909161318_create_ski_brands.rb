class CreateSkiBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :ski_brands do |t|
      t.string :name
      t.string :subtitle
      t.text :body
      t.text :main_image
      t.text :thumb_image

      t.timestamps
    end
  end
end
