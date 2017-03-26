class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :require_login

  # GET /projects
  # GET /projects.json
  def index
    # @projects = Project.all
    @teams = []
    @allTeams = current_user.teams
    @allTeams.each do |team|
      if (!team.project.nil?)
        @teams.push(team)
      end
    end
    @user = current_user
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tasks = current_project.tasks
  end

  # GET /projects/new
  def new
    @project = Project.new
    @team_id = params[:team_id]
    @read_only = true
    if @team_id.nil?
      @read_only = false
    end

  end

  # GET /projects/1/edit
  def edit
    @team_id = current_project.team.id
    @read_only = true
    if @team_id.nil?
      @read_only = false
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def current_project
    Project.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :team_id)
    end

    def require_login
      unless current_user
        redirect_to login_url
      end
    end
end
