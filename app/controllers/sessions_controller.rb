class SessionsController < ApplicationController
  before_action :no_user,only: :destroy
  before_action :logined,only: :create
  
  def create
    user=User.find_by(register_id: params[:session][:register_id])
    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      flash[:notice]="ログインしました"
      redirect_to mypage_path
    else
      flash[:alert]="ログインに失敗しました"
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
      flash[:notice]="ログアウトしました"
    redirect_to root_path
  end
  
  private
  
  def no_user
    unless @current_user
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end
  
  def logined
    if @current_user
      flash[:alert] = "すでにログイン中です"
      redirect_to root_path
    end
  end
  
end
