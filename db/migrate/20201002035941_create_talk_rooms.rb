class CreateTalkRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :talk_rooms do |t|
      t.integer   :room_name

      t.timestamps
    end
  end
end
