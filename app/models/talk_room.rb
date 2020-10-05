class TalkRoom < ApplicationRecord

  has_many :room_users,       dependent: :destroy
  has_many :talk,             dependent: :destroy
  has_many :room_mediums,     dependent: :destroy
  has_many :room_note,        dependent: :destroy
  has_many :room_albums,      dependent: :destroy
  has_many :room_favorites,   dependent: :destroy
  has_many :room_events,      dependent: :destroy
end
