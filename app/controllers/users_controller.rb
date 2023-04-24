class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "edit successfully"
        redirect_to user_path(@user.id)
    else
        @user = User.find(params[:id])
        flash[:notice] = "edit error"
        render :edit
    end
  end

  def index
    @users = User.page(params[:page])
    @book = Book.new
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(user.id)
    else
      @user = User.find(params[:id])
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
