class CommentsController < ApplicationController
  
  before_action :no_user
  
  def create
    @comment=Comment.new(comment_params)
    if @comment.save
      flash[:notice]="コメントを投稿しました"
      redirect_to @comment.board
    else
      flash[:comment] = @comment
      flash[:error_messages] = @comment.errors.full_messages
      redirect_back fallback_location: @comment.board
    end
  end

  def destroy
    @comment=Comment.find(params[:id])
    @comment.delete
    flash[:notice]="コメントを削除しました"
    redirect_to @comment.board
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:user_id,:board_id,:content)
  end
  
  private
  
  def no_user
    unless @current_user
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end
  
end
