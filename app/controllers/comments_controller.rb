class CommentsController < ApplicationController
	def create
		@project = Project.find(params[:project_id])
		@bug = @project.bugs.find(params[:bug_id])
		@comment = @bug.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			flash[:success]="Comment was created successfully"
			redirect_to project_bug_path(@project, @bug)
		else
			flash[:danger]="Comment was not created"
			redirect_back(fallback_location: project_bug_path(@project, @bug))
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:description)
	end

end
