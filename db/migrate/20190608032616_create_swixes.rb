class CreateSwixes < ActiveRecord::Migration[5.2]
  def change
    create_table :swixes do |t|

      t.timestamps
    end
  end
end
