class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.integer   :user_id
      t.integer   :user_post_id
      t.text      :post_comment

      t.timestamps
    end
  end
end
