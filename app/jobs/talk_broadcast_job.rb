class TalkBroadcastJob < ApplicationJob
  queue_as :default

  def perform(talk)
    ActionCable.server.broadcast "talk_room_channel_#{talk.talk_room_id}", talk: send_talk(talk)
  end

  private

  # ブロードキャストするデータ生成

  def send_talk(talk)
    ApplicationController.render_with_signed_in_user(talk.user, partial: 'users/user_talk', locals: {talk: talk})
    binding.pry
  end

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
