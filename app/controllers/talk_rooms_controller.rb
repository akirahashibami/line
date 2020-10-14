class TalkRoomsController < ApplicationController

  def new
    # code
  end

  def create

  end

  def show
  end

  def index
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
end
