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
    node = DClient.new("192.168.1.13", 11112, ae: "HIPL", host_ae: "DCM4CHEE")
    uploaded_io.each do |tmpFile|
      node.send(tmpFile.tempfile.path)
      sleep 1
      lastSavedStudy = StudyTable.last
      @study.study_uid = lastSavedStudy[:study_iuid]
      existing_record = current_user.studies.find_by(study_uid: @study.study_uid)
      @study.patient_id = params[:study][:patient_id]
      @study.num_instances = lastSavedStudy[:num_instances]
      if !existing_record.nil?
        if existing_record[:patient_id] == @study.patient_id
          existing_record.update_attributes(:updated_at => DateTime.now, :num_instances => @study.num_instances )
        else
          flash[:invalid] = "File not uploaded as it is under a different patient"
        end
      else
        @study.save
      end
    end
    redirect_to :back
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