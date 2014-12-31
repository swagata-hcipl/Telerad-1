class StudiesController < ApplicationController
  def index
  	@study = Study.find(params[:id])
  end

  def create
  end

  def index

  end
end
