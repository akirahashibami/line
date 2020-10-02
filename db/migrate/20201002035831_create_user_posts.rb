class CreateUserPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_posts do |t|
      t.string    :user_id
      t.text      :text

      t.timestamps
    end
  end
end
