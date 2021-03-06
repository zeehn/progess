class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :destroy, :update, :change_status]

  def index
    @to_dos = current_user.tasks.where(status: 'to-do')
    @doings = current_user.tasks.where(status: 'doing')
    @dones = current_user.tasks.where(status: 'done')
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task created successfuly."
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "Task updated successfully."
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:notice] = "Task deleted successfully."
      redirect_to tasks_path
    end
  end

  def change_status
    if @task.update_attributes(status: params[:status])
      # flash[:notice] = "Task status updated."
      redirect_to tasks_url
    end
  end

  private
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end