class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update, :show]
  # def show
  #   begin
  #   @user = User.find(params[:id])
  #   if (current_user == nil)
  #     redirect_to login_path
  #   end
  #   if current_user != @user
  #     @user = current_user
  #   end
  #   rescue
  #     if (current_user != nil)
  #       redirect_to current_user
  #     else
  #       redirect_to login_path
  #     end
  #   end
  # end


  def new
    @user = User.new
    @button_text = "Submit"
  end

  def show
    @user = User.find(params[:id])
    @allTeams = @user.teams
    @team_count = @allTeams.count
    @project_count = 0
    @allTeams.each do |team|
      if (!team.project.nil?)
        @project_count += 1
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

  def edit
    @user = User.find(params[:id])
    @button_text = "Save"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      begin
        @user = User.find(params[:id])
        # redirect_to(root_url) unless @user == current_user
        redirect_to(current_user) unless current_user?(@user)
      rescue
        redirect_to(current_user)
      end

    end
end
