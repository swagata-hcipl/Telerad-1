class CommentsController < ApplicationController
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new(:study_id => params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
      format.js
    end
  end

 # POST /comments
  # POST /comments.json
  def create

    @comment = Comment.new(comment_params, user: current_user)
    @comment.user_id = current_user.id
    #@patient = Patient.find(params[:id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :controller => "patients", :action => "index",:id => current_patient, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  # GET /comments
  # GET /comments.json
  def show
    @comments = Comment.where(:study_id => params[:id])
    @study = Study.find_by(:id => params[:id])

    respond_to do |format|
      format.json { render json: @comments }
      format.js
    end
  end
private
  def current_study
    Study.find_by(:id => params[:comment][:study_id])
  end
  def comment_params
    params.require(:comment).permit(:comment, :study_id)
  end
  def current_patient
    @patient = Patient.where(id: params[:id])
  end
end