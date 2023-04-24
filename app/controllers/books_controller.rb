class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page])
    @book = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
    else
   render :new
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


end
