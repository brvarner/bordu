class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /projects or /projects.json
  def index
    @projects = Project.where(creator_id: current_user.id)

    if @projects.blank?
      flash[:alert] = 'No projects found.'
      redirect_to root_path and return
    end

    # this line is causing an error that also renders visually on the page itself every time the user
    # navigates to a different page
    @projects = @projects.includes(tasks: %i[assignments updates creator])

    @tasks_by_status = @projects.each_with_object({}) do |project, hash|
      proj_tasks = project.tasks
      hash[project.id] = {
        'unassigned' => proj_tasks.where(status: 'unassigned'),
        'assigned' => proj_tasks.where(status: 'assigned'),
        'in progress' => proj_tasks.where(status: 'in progress'),
        'completed' => proj_tasks.where(status: 'completed')
      }
    end

    authorize @projects
  end

  # GET /projects/1 or /projects/1.json
  def show
    authorize @project
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project
  end

  # GET /projects/1/edit
  def edit
    authorize @project
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.creator = current_user
    @project.complete = false

    authorize @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    authorize @project
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description, :complete)
  end
end
