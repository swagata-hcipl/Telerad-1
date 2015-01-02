class StudiesController < ApplicationController
  
  def new
  	# @study = Study.new
  	# respond_to do |format|
   #    format.html # new.html.erb
   #    format.json { render json: @study }
   #  end
  end

  def create
    @study = current_user.studies.create(:patient => current_patient)
  end

  def upload
    # @user = authenticate_user.patients.where(params[:id])
    debugger
  end

  private
    def current_patient
      Patient.where(id: params[:id])
    end

end