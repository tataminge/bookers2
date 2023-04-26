class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def index
    @users = User.page(params[:page])
    @book = Book.new
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "edit successfully"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "is too short (minimum is 2 characters)"
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
