class BugsController < ApplicationController
  before_action :set_project, only: [:new, :create,:edit,:update,:show]
  before_action :set_bug, only: [:edit,:update,:destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def new
    @bug = Bug.new
  end

  def create
    @bug = @project.bugs.new(bug_params)
    @bug.qa = current_user

    if @bug.save
      flash[:success] = "Bug was successfully created"
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

	def update
	  if @bug.update(bug_params)
      flash[:success] = "Bug was successfully updated"
	    redirect_to project_bug_path(@project, @bug)
	  else
	    render :edit, status: :unprocessable_entity
	  end
	end

	def show
	  @bug = @project.bugs.find(params[:id])
    @comment = Comment.new
    @comments = @bug.comments.paginate(page: params[:page], per_page: 5)
	end

	def destroy
    @project = @bug.project

    if @bug.destroy
      flash[:success] = "Bug was successfully deleted."
    else
      flash[:error] = "Error deleting bug."
    end

    redirect_to project_path(@project)
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(
      :title, :description, :deadline,
      :screenshot, :bug_type, :bug_status,
      :developer_id
    )
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end
end
