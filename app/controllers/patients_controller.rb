class PatientsController < ApplicationController
  before_filter :authenticate_user
  def index
    @study = current_user.studies.new(:patient => Patient.find(params[:id]))
    @studies = Patient.find(params[:id]).studies.where.not(study_uid: nil)
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = current_user.patients.create(patient_params)
    if @patient
      flash[:notice] = "Patient Created successfully"
      flash[:color]= "valid"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render "new"
    end
  end

  def edit
    @patient = current_user.patients.find(params[:id])
    if !@patient
      flash[:notice] = "Black Sheeep, hahahahahaha!"
      flash[:color]= "invalid"
      redirect_to :controller => 'users', :action => 'index'
    else
      render 'edit'
    end
  end

  def update
    @patient = current_user.patients.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:notice] = "Patient Updated successfully"
      flash[:color]= "valid"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render "edit"
    end
  end

  private
  def patient_params
    params.require(:patient).permit(:name, :address, :gender, :dob, :pincode)
  end

  def current_study
    current_user.studies.where(id: params[:id])

  end
end
