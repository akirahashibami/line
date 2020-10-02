class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      t.integer   :user_id
      t.integer   :talk_room_id
      t.text      :talk

      t.timestamps
    end
  end
end
