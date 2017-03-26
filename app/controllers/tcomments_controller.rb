class TcommentsController < ApplicationController
  before_action :set_tcomment, only: [:show, :edit, :update, :destroy]
  before_filter :require_login

  # GET /tcomments
  # GET /tcomments.json
  def index
    # @tcomments = Tcomment.all
    # @tcomments = Task.find(params[:task_id]).tcomments
    redirect_to(current_user)
  end

  # GET /tcomments/1
  # GET /tcomments/1.json
  def show
    @task = Task.find(params[:task_id])
  end

  # GET /tcomments/new
  def new
    @user_id = session[:user_id]
    @tcomment = Tcomment.new
    @task = Task.find(params[:task_id])
  end

  # GET /tcomments/1/edit
  def edit
    @task = Task.find(params[:task_id])
    @user_id = session[:user_id]
  end

  # POST /tcomments
  # POST /tcomments.json
  def create
    @tcomment = Tcomment.new(tcomment_params)

    respond_to do |format|
      if @tcomment.save
        flash[:success] = "Comment was successfully created."
        format.html { redirect_to task_tcomment_path(:id => @tcomment.id) }
        format.json { render :show, status: :created, location: @tcomment }
      else
        format.html { render :new }
        format.json { render json: @tcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tcomments/1
  # PATCH/PUT /tcomments/1.json
  def update
    respond_to do |format|
      if @tcomment.update(tcomment_params)
        flash[:success] = "Comment was successfully updated."
        format.html { redirect_to task_tcomment_path(:id => @tcomment.id) }
        format.json { render :show, status: :ok, location: @tcomment }
      else
        format.html { render :edit }
        format.json { render json: @tcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tcomments/1
  # DELETE /tcomments/1.json
  def destroy
    @tcomment.destroy
    respond_to do |format|
      flash[:success] = "Comment was successfully destroyed."
      format.html { redirect_to task_tcomments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tcomment
      @tcomment = Tcomment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tcomment_params
      params.require(:tcomment).permit(:content, :user_id, :task_id)
    end

    def require_login
      unless current_user
        redirect_to login_url
      end
    end
end
