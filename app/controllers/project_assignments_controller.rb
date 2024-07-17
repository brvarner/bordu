class ProjectAssignmentsController < ApplicationController
  before_action :set_project_assignment, only: %i[ show edit update destroy ]

  # GET /project_assignments or /project_assignments.json
  def index
    @project_assignments = ProjectAssignment.all
  end

  # GET /project_assignments/1 or /project_assignments/1.json
  def show
  end

  # GET /project_assignments/new
  def new
    @project_assignment = ProjectAssignment.new
  end

  # GET /project_assignments/1/edit
  def edit
  end

  # POST /project_assignments or /project_assignments.json
  def create
    @project_assignment = ProjectAssignment.new(project_assignment_params)

    respond_to do |format|
      if @project_assignment.save
        format.html { redirect_to project_assignment_url(@project_assignment), notice: "Project assignment was successfully created." }
        format.json { render :show, status: :created, location: @project_assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_assignments/1 or /project_assignments/1.json
  def update
    respond_to do |format|
      if @project_assignment.update(project_assignment_params)
        format.html { redirect_to project_assignment_url(@project_assignment), notice: "Project assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @project_assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_assignments/1 or /project_assignments/1.json
  def destroy
    @project_assignment.destroy!

    respond_to do |format|
      format.html { redirect_to project_assignments_url, notice: "Project assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_assignment
      @project_assignment = ProjectAssignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_assignment_params
      params.require(:project_assignment).permit(:user_id_id, :project_id_id)
    end
end
