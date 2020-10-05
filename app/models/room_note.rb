class RoomNote < ApplicationRecord

  has_many :room_note_mediums,    dependent: :destroy

  belongs_to :user
  belongs_to :talk_room
end
