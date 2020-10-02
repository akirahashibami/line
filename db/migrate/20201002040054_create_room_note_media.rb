class CreateRoomNoteMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :room_note_media do |t|
      t.integer   :user_id
      t.integer   :talk_id

      t.timestamps
    end
  end
end
