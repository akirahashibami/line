class TalkRoomsController < ApplicationController

  def new
    # code
  end

  def create
    # code
  end

  def show
    # code
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
    # code
  end
end
