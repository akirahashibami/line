class TalkRoomsController < ApplicationController

  def new
    # code
  end

  def create
    room = TalkRoom.create
    RoomUser.create(user_id: current_user.id, talk_room_id: room.id)
    RoomUser.create(user_id: params[:room_user][:user_id], talk_room_id: room.id)
    # 新規ルーム作成時に、showでparams[:user_id]を使えるようにする
    user = User.find(params[:room_user][:user_id])
    redirect_to talk_room_path(room, user_id: user)
  end

  def show
    @user = User.find(params[:user_id])
    @room = TalkRoom.find(params[:id])
    @talks = @room.talk
  end

  def index
    @users = User.where.not(id: current_user.id)
    @room = TalkRoom.new
  end

  def edit
    # code
  end

  def update
    # code
  end

  def destroy

  end

  private

  def talk_room_params
    params.require(:talk_room)
  end
end
