class PatientsController < ApplicationController
  
  before_filter :authenticate_user

  def index
    @studies = Study.where patient_id: params[:id]
  end

  def new
    @patient = Patient.new
  end

  def create
    # @patient = Patient.new(patient_params)
    @patient = authenticate_user.patients.build(patient_params)
    if @patient.save
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

  def authenticate_patient_user

  end
end
