class TaskUpdatesController < ApplicationController
  before_action :set_task_update, only: %i[ show edit update destroy ]

  # GET /task_updates or /task_updates.json
  def index
    @task_updates = TaskUpdate.all
  end

  # GET /task_updates/1 or /task_updates/1.json
  def show
  end

  # GET /task_updates/new
  def new
    @task_update = TaskUpdate.new
  end

  # GET /task_updates/1/edit
  def edit
  end

  # POST /task_updates or /task_updates.json
  def create
    @task_update = TaskUpdate.new(task_update_params)

    respond_to do |format|
      if @task_update.save
        format.html { redirect_to task_update_url(@task_update), notice: "Task update was successfully created." }
        format.json { render :show, status: :created, location: @task_update }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_updates/1 or /task_updates/1.json
  def update
    respond_to do |format|
      if @task_update.update(task_update_params)
        format.html { redirect_to task_update_url(@task_update), notice: "Task update was successfully updated." }
        format.json { render :show, status: :ok, location: @task_update }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_updates/1 or /task_updates/1.json
  def destroy
    @task_update.destroy!

    respond_to do |format|
      format.html { redirect_to task_updates_url, notice: "Task update was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_update
      @task_update = TaskUpdate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_update_params
      params.require(:task_update).permit(:task_id_id, :author_id_id, :body)
    end
end
