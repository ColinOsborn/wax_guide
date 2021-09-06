class AddGrindToSkis < ActiveRecord::Migration[6.0]
  def change
    add_column :skis, :grind, :string
  end
end
