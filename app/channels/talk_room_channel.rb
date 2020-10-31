class TalkRoomChannel < ApplicationCable::Channel

  # 接続された時
  def subscribed
    # フロントとバックが通信している時(お互いを監視している時)に実行される
    stream_from "talk_room_channel_#{params['room_id']}"
  end

  # 切断された時
  def unsubscribed
  end

  def speak(talk)
    # Talkモデル内、talkカラムに、(talk)に渡されたvalue['文字列']が保存される
    talk = Talk.new(talk: talk['talk'][0],
                    user_id: talk['talk'][1].to_i,
                    talk_room_id: talk['talk'][2].to_i)
    talk.save
    # 同じchannel名の全てにインプットタグに入力された文字を配信する
    ActionCable.server.broadcast "talk_room_channel_#{params['room_id']}", talk: talk['talk'], user_id: talk['user_id'],created_at: talk[:created_at].strftime("%H:%M")
    binding.pry
  end

end
