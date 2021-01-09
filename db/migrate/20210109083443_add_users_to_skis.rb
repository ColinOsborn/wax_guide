class AddUsersToSkis < ActiveRecord::Migration[6.0]
  def change
    add_reference :skis, :user, index: true, foreign_key: true
  end
end
