class BoardsController < ApplicationController
  before_action :set_board,only: %i[show edit update destroy]
  before_action :no_user,only: %i[new create edit update destroy]
  
  def win
    @wins = @client.search("シャドバ 連勝 -まとめ -youtube", count: 10, result_type: "recent", exclude: "retweets",filter: "images",tweet_mode: "extended")
  end
  
  def hot
    @hot = @client.search("シャドバ -まとめ -youtube -販売 min_retweets:100", count: 10, result_type: "recent",tweet_mode: "extended")
  end
    
  
  def index
    @board_all=Board.all
    @boards=Board.page(params[:page])
    @esports = @client.search("from:esports_rage exclude:retweets", count: 10, result_type: "recent",tweet_mode: "extended")
    @wins = @client.search("シャドバ 連勝 -まとめ -youtube", count: 10, result_type: "recent", exclude: "retweets",filter: "images",tweet_mode: "extended")
    @ret = @client.search("シャドバ -まとめ -youtube -販売 min_retweets:200", count: 10, result_type: "recent",tweet_mode: "extended")
    @official = @client.search("from:shadowverse_jp exclude:retweets", count: 10, result_type: "recent",tweet_mode: "extended")
  end

  def new
    @board=Board.new(flash[:board])
  end
  
  def create
    @board=Board.new(board_params)
    if @board.save
      flash[:notice]="記事「#{@board.title}」を投稿しました"
      redirect_to root_path
    else
      flash[:board] = @board
      flash[:error_messages] = @board.errors.full_messages
      redirect_back fallback_location: new_board_path
    end
  end
  
  def show
    @comment=Comment.new(board_id: @board.id)
    @like=Like.new(board_id: @board.id)
  end

  def edit
    if flash[:board]
      @board.attributes = flash[:board] 
    end
  end
  
  def update
    if @board.update(board_params)
      flash[:notice]="記事「#{@board.title}」を編集しました"
      redirect_to @board
    else
      flash[:board] = @board
      flash[:error_messages] = @board.errors.full_messages
      redirect_back fallback_location: edit_board_path
    end
  end
  
  def destroy
    flash[:alert]="記事「#{@board.title}」を削除しました"
    @board.destroy
    redirect_to root_path
  end
  
  private
  
  def board_params
    params.require(:board).permit(:user_id,:title,:content)
  end
  
  def set_board
    @board=Board.find(params[:id])
  end
  
  def no_user
    unless @current_user
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end
  
end
