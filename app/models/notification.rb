class Notification < ApplicationRecord
  # 作成日時を降順にし、常に新しいデータから順番に取得
  default_scope -> { order(created_at: :desc) }

  # optional: true => nilを許可する
  belongs_to :talk,           optional: true
  belongs_to :talk_room,      optional: true
  belongs_to :room_mediums,   optional: true
  belongs_to :visitor,        optional: true,  class_name: 'User',  foreign_key: 'visitor_id'
  belongs_to :visited,        optional: true,  class_name: 'User',  foreign_key: 'visited_id'
end
