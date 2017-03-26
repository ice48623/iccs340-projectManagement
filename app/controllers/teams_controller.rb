class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_filter :require_login

  def current_team
    Team.find(params[:id])
  end

  # GET /teams
  # GET /teams.json
  def index
    # @teams = Team.all
    @teams = current_user.teams
    @user = current_user
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @user = current_user
    @project = current_team.project

    @display = "display-none"
    if (current_team.project.nil?)
      @display = "btn btn-primary button"
    end

  end

  # GET /teams/new
  def new
    @team = Team.new
    @users = User.where.not(id: current_user.id).to_json.to_s
    @user_in_team = []
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    # @users = User.all.to_json.to_s
    @users = User.where.not(id: current_user.id).to_json.to_s
    @user_in_team = current_team.users.where.not(id: current_user.id)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @user = current_user
    @team.users << @user

    @members = params[:members].split(",")
    @members.each do |id|
      @member = User.where(id: id)
      @team.users << @member
    end

    respond_to do |format|
      if @team.save
        flash[:success] = "Team was successfully created."
        format.html { redirect_to @team }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    update_team_user

    respond_to do |format|
      if @team.update(team_params)
        flash[:success] = "Team was successfully updated."
        format.html { redirect_to @team }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      flash[:success] = "Team was successfully destroyed."
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def add_user
    @user = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    if @team.users.exists?(@user)
      flash[:notice] = "user already in team"
    else
      @team.users << @user
      @team.save
      flash[:notice] = 'add user to team'
      redirect_to @team
    end

  end

  def delete_user
    @user = current_user
    @team = Team.find(params[:team_id])
    if @team.users.exists?(@user)
      @team.users.delete(@user)
      if (@team.users.exists? == false)
        @team.destroy
      end
      redirect_to teams_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :description)
    end

    def require_login
      unless current_user
        redirect_to login_url
      end
    end

    def update_team_user
      @team = current_team
      @team_user = @team.users

      @team_user.each do |user|
        if (user != current_user)
          @team_user.delete(user)
        end
      end

      @members = params[:members].split(",")
      @members.each do |id|
        @member = User.where(id: id)
        if (@member != current_user)
          @team.users << @member
        end
      end
    end

end
