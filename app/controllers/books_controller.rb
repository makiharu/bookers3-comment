class BooksController < ApplicationController
  before_action :authenticate_user!
#  before_action :baria_user, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user,only: [:edit,:update,:destroy]
  def show
    @book = Book.new
  	@onebook = Book.find(params[:id])
    @user = User.find(@onebook.user_id)
    @book_comment = BookComment.new
  end

    #@book_comments = @onebook.book_comments #追加
    #@book_comment = @onebook.book_comments.build
  

  def index
  	@books = Book.all
    @book = Book.new
  end

  def create
    @books = Book.all
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	@book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
    @book.user_id = current_user.id
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

      #url直接防止　メソッドを自己定義してbefore_actionで発動。
  #def baria_user
   # unless params[:id].to_i == current_user.id
    #  redirect_to books_path
   # end
  #end

      def ensure_correct_user
      @book = Book.find(params[:id])
      if @book.user_id != current_user.id
        redirect_to books_path
      end
    end



end



