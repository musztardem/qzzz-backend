class AddStatusToFriendship < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :status, :integer
  end
end
