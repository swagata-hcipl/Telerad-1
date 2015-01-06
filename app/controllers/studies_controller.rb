require 'dicom'
include DICOM

class StudiesController < ApplicationController
  
  def new
  	# @study = Study.new
  	# respond_to do |format|
   #    format.html # new.html.erb
   #    format.json { render json: @study }
   #  end
  end

  def create
    @study = current_user.studies.new
    uploaded_io = params[:study][:dicom_file_upload]
    node = DClient.new("192.168.1.3", 11112, ae: "HIPL", host_ae: "DCM4CHEE")
    uploaded_io.each do |tmpFile|
      node.send(tmpFile.tempfile.path)
      lastSavedStudy = StudyTable.last
      @study.study_uid = lastSavedStudy[:study_iuid]
      @study.patient_id = params[:study][:patient_id]
      @study.save
    end
    # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
  end


  private
    def current_patient
      @patient = Patient.where(id: params[:id])
    end

    def studies_params
      params.require(:study).permit(:patient_id, :user_id, :study_uid, :created_at, :updated_at)
    end

end
