class TalkRoomChannel < ApplicationCable::Channel
  def subscribed
    # フロントとバックが通信している時(お互いを監視している時)に実行される
    stream_from "talk_room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    ActionCable.server.broadcast('talk_room_channel', data)
  end
end
