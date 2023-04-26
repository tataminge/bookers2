class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.page(params[:page])
    @book = Book.new
    if @book.save
      redirect_to book_path(@book.id)
    else
    render :index
    end
  end


  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "can't be blank"
      redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "destroy successfully"
    redirect_to '/books'
  end


  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "edit successfully"
      redirect_to book_path(book.id)
    else
      @book = Book.find(params[:id])
      flash[:notice] = "edit error"
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end


end
