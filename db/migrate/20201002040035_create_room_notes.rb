class CreateRoomNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :room_notes do |t|
      t.integer   :user_id
      t.integer   :talk_room_id
      t.text      :texts

      t.timestamps
    end
  end
end
