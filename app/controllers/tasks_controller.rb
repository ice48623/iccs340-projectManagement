class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :require_login
  # GET /tasks
  # GET /tasks.json
  def index
    redirect_to(current_user)
    # @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = current_task.tcomments
    @task = current_task
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @status = 'pending'
    @project_id = params[:project_id]
    @tasks = ['pending']
    @read_only = true
    if @project_id.nil?
      @read_only = false
    end
  end

  # GET /tasks/1/edit
  def edit
    @status = current_task.status
    @project_id = current_task.project.id
    @read_only = true
    if @project_id.nil?
      @read_only = false
    end
    @tasks = ['pending', 'in-progess', 'testing', 'complete']
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        flash[:success] = "Task was successfully created."
        format.html { redirect_to @task }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        flash[:success] = "Task was successfully updated."
        format.html { redirect_to @task }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      flash[:success] = "Task was successfully destroyed."
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def current_task
    @task = Task.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id)
    end

    def require_login
      unless current_user
        redirect_to login_url
      end
    end
end
