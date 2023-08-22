class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if can?(:manage, Project)
      @projects = Project.where(manager_id: current_user.id)
    else
      @projects = current_user.projects
    end
    @projects=paginate_collection(@projects)
  end

  def new
		@project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.manager = current_user

    if @project.save
      flash[:success] = "Project was created Successfully"
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @bug = @project.bugs.new
    @bugs = @project.bugs
    @bugs = paginate_collection(@bugs)
  end

	def update
    if @project.update(project_params) 
			flash[:success] = "Project was updated successfully"
			redirect_to project_path(@project)
		else
			render 'edit' , status: :unprocessable_entity
		end
	end

	def destroy		
		@project.destroy
		flash[:success] = "Project deleted successfully"
		redirect_to projects_path
	end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
      :name, :description, :deadline, user_ids: [])
  end

  def paginate_collection(collection)
    collection.paginate(page: params[:page], per_page: 5)
  end
end
