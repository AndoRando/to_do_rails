class TasksController < ApplicationController
  before_action :find_list
  before_action :find_task, only: [:edit, :update, :destroy]

  def new
    @task = @list.tasks.new
  end

  def create
    @task = @list.tasks.new(task_params)
    if @task.save
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to list_path(@task.list)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to list_path(@list)
  end

  private
  def task_params
    params.require(:task).permit(:description)
  end

  def find_list
    @list = List.find(params[:list_id])
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
