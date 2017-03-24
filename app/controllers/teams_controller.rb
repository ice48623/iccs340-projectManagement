class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /teams/new
  def new
    @team = Team.new
    @user = User.all
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @user = User.all
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @user = current_user
    @team.users << @user
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
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
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
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
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
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

end
