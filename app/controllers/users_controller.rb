class UsersController < ApplicationController

  def show
    begin
    @user = User.find(params[:id])
    if (current_user == nil)
      redirect_to login_path
    end
    if current_user != @user
      @user = current_user
    end
    rescue
      if (current_user != nil)
        redirect_to current_user
      else
        redirect_to login_path
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


end
