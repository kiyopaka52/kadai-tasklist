class TasksController < ApplicationController
  before_action :require_user_logged_in
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # if logged_in?
    @tasks= current_user.tasks#.order(id: :desc).page(params[:page])
    # @tasks = Task.all
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
   # @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが作成されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクが作成されませんでした'
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクは更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは削除されました'
    redirect_to tasks_url
  end
  

  private
  
  # def set_task
  #   @task = Task.find(params[:id])
  # end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
