class Talk < ApplicationRecord

  belongs_to :user
  belongs_to :talk_room

  has_one_attached :talk_image

  scope :recently, -> { order(updated_at: :desc) }
end
