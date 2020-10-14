class Talk < ApplicationRecord

  belongs_to :user
  belongs_to :talk_room

  # ブロードキャスト
  after_create_commit { TalkBroadcastJob.perform_later self }
  
end
