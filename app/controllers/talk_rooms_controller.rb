class TalkRoomsController < ApplicationController

  def new
    # code
  end

  def create
    # code
  end

  def show
    @room = TalkRoom.find(params[:id])
    @talks = @room.talk
  end

  def index
    # 友だちがクリックされた時
    unless params[:follower].blank?
      @user = User.find_by(id: params[:follower])
      current_room = RoomUser.where(user_id: current_user.id)
      another_room = RoomUser.where(user_id: @user.id)
      unless @user.id == current_user.id
        current_room.each do |cr|
          another_room.each do |ar|
            # ルームが存在する時
            if cr.talk_room_id == ar.talk_room_id
              @is_room = true
              @room = TalkRoom.find_by(id: cr.talk_room_id)
              @talks = @room.talk
            end
          end
        end
        # なければ新規作成
        unless @is_room
          @room = TalkRoom.create
          RoomUser.create(user_id: current_user.id, talk_room_id: @room.id)
          RoomUser.create(user_id: params[:follower].to_i, talk_room_id: @room.id)
        end
      end
    end
    @users = User.where.not(id: current_user.id)

    # トークが新しい順にトークルームを並べる
    latest_talk = Talk.from(Talk.order(created_at: :asc))
                      .group(:talk_room_id)
                      .select(:talk_room_id)
                      .order(created_at: :desc)
    @latest_talks = Array.new
    latest_talk.each do |talk|
      room = TalkRoom.find_by(id: talk.talk_room_id)
      @latest_talks.push(room)
    end
  end

  def edit
    # code
  end

  def update
    # code
  end

  def destroy

  end

  def search
    @users = current_user.followings.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html #htmlがないとエラーが出る
      format.json
    end
  end

  private

  def talk_room_params
    params.require(:talk_room)
  end
end
