class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy update_status]
  before_action :authorize_task

  # GET /tasks or /tasks.json
  def index
    @tasks_by_status = Task.where(project_id: @project.id).includes(%i[creator assignments updates]).group_by(&:status)
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build
    # get rid of unused code
    # authorize @task

    render partial: 'form', locals: { project: @project, task: @task }
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    @task.creator = current_user

    # authorize @task

    respond_to do |format|
      if @task.save
        assign_users_to_task
        html = render_to_string(partial: 'tasks/task', locals: { task: @task }, formats: [:html])
        ActionCable.server.broadcast 'task_channel',
                                     { task_html: html,
                                       task: @task,
                                       status: @task.status, task_id: @task.id }
        format.json do
          render json: {
                   task: @task.as_json(include: :project)
                 }, status: :created
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    pp task_params
    if @task.update(task_params)
      ActionCable.server.broadcast 'task_channel', task: @task
      respond_to do |format|
        format.html { redirect_to project_path(@task.project), notice: 'Task status was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    @task = Task.find(params[:id])
    if @task.update(status: params[:status])
      ActionCable.server.broadcast 'task_channel', { task: @task, action: 'update_status' }
      render json: { success: true }
    else
      render json: { success: false, errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    # authorize @task
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to project_path(@task.project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def authorize_task
    authorize(@task || Task.new(project: @project))
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :title, :description, :status, :project_id)
  end

  def assign_users_to_task
    # TODO: if user doesn't exist, send an email to assigned person with a signup
    # link.
    emails = params[:assigned_user_emails]&.split(',')&.map(&:strip) || []
    emails.each do |email|
      user = User.find_by(email:)
      @task.assignments.create(recipient: user) if user
    end
  end
end
