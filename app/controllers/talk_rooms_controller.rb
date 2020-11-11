class TalkRoomsController < ApplicationController

  def new
    @talk_room = TalkRoom.new
    @talk_room.room_users.new
  end

  def create
    @talk_room = TalkRoom.new(talk_room_params)
    @talk_room.save
  end

  def show
    @room = TalkRoom.find(params[:id])
    @talks = @room.talk
  end

  def index
    # 友だちがクリックされた時のルーム表示判定
    unless params[:follower].blank?
      @user = User.find_by(id: params[:follower])
      current_room = RoomUser.where(user_id: current_user.id)
      another_room = RoomUser.where(user_id: @user.id)
      unless @user.id == current_user.id
        current_room.each do |cr|
          another_room.each do |ar|
            # ルームが存在する時 かつ ルームのユーザーIDが2人まで（グループとの差別化）
            if cr.talk_room_id == ar.talk_room_id && TalkRoom.find_by(id: cr.talk_room_id).users.ids.size == 2
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

    # グループがクリックされた時のルーム判定
    unless params[:room_id].blank?
      @room = TalkRoom.find_by(id: params[:room_id])
      @talks = @room.talk
      @room_name = @room.room_name
    end

    # 知り合いかも？に自分以外のユーザーを表示
    @users = User.where.not(id: current_user.id)

    # トークが新しい順にトークルームを並べる
    # if Talk.exists?
    #   latest_talk = Talk.from(Talk.order(created_at: :asc))
    #                     .group(:talk_room_id)
    #                     .select(:talk_room_id)
    #                     .order(created_at: :desc)
    #   @latest_talks = Array.new
    #   binding.pry
    #   latest_talk.each do |talk|
    #     room = TalkRoom.find_by(id: talk.talk_room_id)
    #     unless room.users.where(id: current_user.id).blank?
    #       @latest_talks.push(room)
    #     end
    #   end  
    end

    #　自分が参加しているグループトークの表示
     # 自分が参加しているグループを探す
    current_user_entry_group = current_user.talk_room.where.not(room_name: :nill).pluck(:talk_room_id)
     # 名前順で並び替え
    @entry_room = TalkRoom.where(id: current_user_entry_group).order(room_name: :asc)
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
    # ルーム作成時に自分のidが入るようにしておく
    params[:talk_room][:user_ids].push(current_user.id)
    # 配列の中身を全てintegerに
    params[:talk_room][:user_ids].map!(&:to_i)
    params[:talk_room].permit(:room_name, { user_ids: []})
  end
end
