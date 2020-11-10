class ChangeDataRelationshipsToFolloweId < ActiveRecord::Migration[5.2]
  def change
    change_column :relationships, :following_id, :integer
    change_column :relationships, :follower_id, :integer
  end
end
