class Talk < ApplicationRecord

  belongs_to :user
  belongs_to :talk_room

  scope :recently, -> { order(updated_at: :desc) }
end
