class ChangeDataRelationshipsToFolloweId < ActiveRecord::Migration[5.2]
  def change
    change_column :relationships, :following_id, :'integer USING CAST(column_name AS integer)'
    change_column :relationships, :follower_id, :'integer USING CAST(column_name AS integer)'
  end
end
