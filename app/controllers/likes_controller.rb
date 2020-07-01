class LikesController < ApplicationController
  
  before_action :no_user
  
  def create
    @like=Like.new(like_params)
    @like.save
    flash[:notice]="お気に入り登録しました"
    redirect_to @like.board
  end

  def destroy
    @liked=Like.find_by(like_params)
    flash[:notice]="お気に入りを解除しました"
    @liked.destroy
    redirect_to @liked.board
  end
  
  private 
  
  def like_params
    params.require(:like).permit(:user_id,:board_id)
  end
  
  def no_user
    unless @current_user
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end
  
end
