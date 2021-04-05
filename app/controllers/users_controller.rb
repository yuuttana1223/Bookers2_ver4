class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_add_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_add_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user.id)
    end
  end
end
