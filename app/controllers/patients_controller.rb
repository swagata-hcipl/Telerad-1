class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:notice] = "Patient Created successfully"
      flash[:color]= "valid"
      redirect_to(:action => :index)
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render "new"
    end
  end

  def show
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:notice] = "Patient Updated successfully"
      flash[:color]= "valid"
      redirect_to(:action => :index)
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
end
