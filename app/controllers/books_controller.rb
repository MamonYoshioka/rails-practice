class BooksController < ApplicationController
  # トップ画面
  def top
  end

  # 一覧表示
  def index
    # 一覧表示のため、インスタンス名は複数形にした。
    @books = Book.all

    # 新規投稿の画面
    @book = Book.new
  end

  # 新規投稿ページ
  def new
    # 新規投稿画面を一覧画面と一緒に表示させるため、
    # newメソッドのインスタンス変数(@book = Book.new)をindexメソッドに移動
  end

  # 新規投稿登録ページ
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "successfully!!"
      redirect_to @book
    else
      @books = Book.all
      render :index

    end
  end

  # 詳細ページ
  def show
    @book = Book.find(params[:id])
  end

  # 編集ページ
  def edit
    @book = Book.find(params[:id])
  end

  # 内容の更新
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully!!"
      redirect_to @book
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  # 削除ページ
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
