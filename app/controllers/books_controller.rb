class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_current_user_book, only: [:edit, :update, :destroy]
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id]) 
    @books = Book.all
    @user = @book.user
    @booknew = Book.new
  end

  def new
    @book = Book.new
  end

  # 1:N 
      # 相手のモデル名_id = 相手のインスタンス.id
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save
       flash[:notice] = "Book was successfully created."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       @user = current_user
       render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book was successfully updated."
       redirect_to book_path(@book)
    else
       render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def check_current_user_book
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end
end
