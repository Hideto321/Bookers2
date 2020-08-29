class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_current_user_plofile, only: [:edit, :update ]
    
    def index
        @users = User.all
        @user_new = User.new
        @book = Book.new
        # logger.debug(current_user)
        @user = User.find(current_user.id)
    end

    def show
        @user = User.find(params[:id])
        @books = @user.books
        @book = Book.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
      if @user.update(user_params)
          flash[:notice] = "was successfully update."
        redirect_to user_path(@user.id)

      else
        render action: :edit
      end
    end

    def create
        @user = User.new
        user.save
        redirect_to edit_book
    end

    private
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

  def check_current_user_plofile
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end
end
