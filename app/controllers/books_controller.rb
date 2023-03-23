class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def  create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
   if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
   else
      @user = current_user
      @books = Book.all
      render :index
   end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end
  

  def edit
     @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
       render :edit
    end
  end


  private

  def books_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to books_path unless @user == current_user
  end
end
