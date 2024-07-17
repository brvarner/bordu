class TaskAssignmentsController < ApplicationController
  before_action :set_task_assignment, only: %i[ show edit update destroy ]

  # GET /task_assignments or /task_assignments.json
  def index
    @task_assignments = TaskAssignment.all
  end

  # GET /task_assignments/1 or /task_assignments/1.json
  def show
  end

  # GET /task_assignments/new
  def new
    @task_assignment = TaskAssignment.new
  end

  # GET /task_assignments/1/edit
  def edit
  end

  # POST /task_assignments or /task_assignments.json
  def create
    @task_assignment = TaskAssignment.new(task_assignment_params)

    respond_to do |format|
      if @task_assignment.save
        format.html { redirect_to task_assignment_url(@task_assignment), notice: "Task assignment was successfully created." }
        format.json { render :show, status: :created, location: @task_assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_assignments/1 or /task_assignments/1.json
  def update
    respond_to do |format|
      if @task_assignment.update(task_assignment_params)
        format.html { redirect_to task_assignment_url(@task_assignment), notice: "Task assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @task_assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_assignments/1 or /task_assignments/1.json
  def destroy
    @task_assignment.destroy!

    respond_to do |format|
      format.html { redirect_to task_assignments_url, notice: "Task assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_assignment
      @task_assignment = TaskAssignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_assignment_params
      params.require(:task_assignment).permit(:user_id_id, :task_id_id)
    end
end
