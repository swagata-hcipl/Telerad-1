class CommentsController < ApplicationController
  def new
    @comment = Study.comments.build(comment_params)
  end

  def create
    # @patient = Patient.new(patient_params)
    @comment = authenticate_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment Created successfully"
      flash[:color]= "valid"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render "new"
    end
  end

  def show
    @comments = Study.comments
  end
end

private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end