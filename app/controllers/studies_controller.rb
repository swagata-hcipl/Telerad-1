class StudiesController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def comment_params
  	params.require(:study).permit(:comment)
  end

end

