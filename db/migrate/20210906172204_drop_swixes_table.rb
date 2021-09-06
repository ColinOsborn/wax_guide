class DropSwixesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :swixes
  end
end
