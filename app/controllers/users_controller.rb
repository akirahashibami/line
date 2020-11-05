class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # ここからルームの分岐
    @current_room = RoomUser.where(user_id: current_user.id)
    @another_room = RoomUser.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_room.each do |cr|
        @another_room.each do |ar|
          # ルームが存在する時
          if cr.talk_room_id == ar.talk_room_id
            @is_room = true
            @room_id = cr.talk_room_id
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_back(fallback_location: user_path(current_user))
  end

  def destroy
    # code
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
