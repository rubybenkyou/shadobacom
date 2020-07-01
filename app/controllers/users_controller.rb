class UsersController < ApplicationController
  before_action :set_user,only: %i[show edit update destroy]
  before_action :no_user,only: %i[me edit update destroy]
  before_action :logined,only: %i[login new create]
  
  def login
  end
  
  
  def new
    @user=User.new(flash[:user])
  end

  def create
    @user=User.new(user_params)
    if @user.save
      session[:user_id]=@user.id
      flash[:notice] = "新規ユーザー登録しました"
      redirect_to mypage_path
    else
      flash[:user] = @user
      flash[:error_messages] = @user.errors.full_messages
      redirect_back fallback_location: new_user_path
    end
  end

  def me
    @user=User.find_by(id: @current_user.id)
  end
  
  def show
    if @current_user && @user.id == @current_user.id
      redirect_to mypage_path
    end
  end
  
  def edit
    if flash[:user]
      @user.attributes = flash[:user] 
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:notice]="ユーザー情報を編集しました"
      redirect_to @user
    else
      flash[:user] = @user
      flash[:error_messages] = @user.errors.full_messages
      redirect_back fallback_location: edit_user_path
    end
  end
  
  def destroy
    @user.destroy
    session.delete(:user_id)
      flash[:notice]="退会しました"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:register_id,:password,:password_confirmation,:name)
  end
  
  def set_user
    @user=User.find(params[:id])
  end
  
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
