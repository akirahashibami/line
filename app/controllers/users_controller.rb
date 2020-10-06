class UsersController < ApplicationController

  def show
    # code
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update
  end

  def destroy
    # code
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
