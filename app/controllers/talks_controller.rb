class TalksController < ApplicationController

  def create
    
  end

  def update
    # code
  end

  private

  def talk_params
    params.require(:talk).permit(:talk)
  end
end
