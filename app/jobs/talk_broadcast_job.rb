class TalkBroadcastJob < ApplicationJob
  queue_as :default

  def perform(talk)
    # talkの内容がnil(画像のみの場合)talk_room_channelに対して生成したデータをブロードキャスト
    if talk.talk == nil
      ActionCable.server.broadcast('talk_room_channel', data(talk))
    end
  end

  private

  # ブロードキャストするデータ生成
  def data(talk)
    {
      talkhtml:
      ApplicationController.renderer.render(
        partial: 'users/user-talk-image',
        locals: { talk: talk}
      )
    }
  end

end
