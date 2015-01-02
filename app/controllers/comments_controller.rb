class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Commented successfully"
      flash[:color]= "valid"
      redirect_to(:action => :show)
    else
      flash[:notice] = "Comment can't be empty"
      flash[:color]= "invalid"
      render "show"
    end
  end

  def show
  	@comments = Comment.all
  end

  def edit
  	@comment = Comment.find(params[:id])
  end

  def history
  	@comment = Comment.find(params[:id])
  	@versions = @comment.versions
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
