class RoomAlbum < ApplicationRecord

  belongs_to :user
  belongs_to :talk_room
  
end
