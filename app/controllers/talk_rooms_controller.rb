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
    @room = TalkRoom.find(params[:id])
    @talks = @room.talk
  end

  def index
    unless params[:follower].blank?
      @user = User.find_by(id: params[:follower])
      @current_room = RoomUser.where(user_id: current_user.id)
      @another_room = RoomUser.where(user_id: @user.id)
      unless @user.id == current_user.id
        @current_room.each do |cr|
          @another_room.each do |ar|
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
          @room = TalkRoom.new
          @room_user = RoomUser.new
        end
      end
    end
    @users = User.where.not(id: current_user.id)
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
    @users = current_user.followers.where('name LIKE(?)', "%#{params[:keyword]}%")
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
