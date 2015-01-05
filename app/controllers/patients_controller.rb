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
    @patient = Patient.find(params[:id])
    if @patient.user_id!=authenticate_user.id
      flash[:notice] = "Black Sheeep, hahahahahaha!"
      flash[:color]= "invalid"
      redirect_to :controller => 'users', :action => 'index'
    else
      render 'edit'
    end
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:notice] = "Patient Updated successfully"
      flash[:color]= "valid"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render "new"
    end
  end

  private
  def patient_params
    params.require(:patient).permit(:name, :address, :gender, :dob, :pincode)
  end

<<<<<<< HEAD
  def current_study
    current_user.studies.where(id: params[:id])
=======
  def authenticate_patient_user

>>>>>>> 0b3fcdc33e803c42f74b6b39fadd0424dd6a3e03
  end
end
