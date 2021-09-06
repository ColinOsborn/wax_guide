class RemoveUsersTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :skis
    drop_table :users
  end
end
