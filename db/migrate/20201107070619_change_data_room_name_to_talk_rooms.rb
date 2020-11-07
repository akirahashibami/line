class ChangeDataRoomNameToTalkRooms < ActiveRecord::Migration[5.2]
  def change

    change_column :talk_rooms, :room_name, :string
  end
end
