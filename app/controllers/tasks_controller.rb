class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy]
  
  def index
    
  end
      
  def show
  end
    
  def new
  end
    
  def create
    @task = current_user.tasks.build(task_parameter)
      
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order("created_at DESC").page(params[:page])
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render "toppages/index"
    end
  end
    
  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end
    
  def update
      
    if @task.update(task_parameter)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'タスクが更新されませんでした'
      render :edit
    end
  end
    
  def destroy
    @task.destroy
      
    flash[:success] = 'タスクは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end    
      
  private
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  def task_parameter
    params.require(:task).permit(:content, :status)
  end  
end

