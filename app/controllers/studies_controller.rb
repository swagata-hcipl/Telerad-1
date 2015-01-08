require 'dicom'
include DICOM

class StudiesController < ApplicationController

  def index

  end

  def new
  	@study = Study.new
  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @study }
    end
  end

  def create
    @study = current_user.studies.new
    uploaded_io = params[:study][:upload]
    node = DClient.new("192.168.1.2", 11112, ae: "HIPL", host_ae: "DCM4CHEE")
    uploaded_io.each do |tmpFile|
      dcm = DObject.read(tmpFile.tempfile.path)
      @study.study_uid = dcm.value("0020,000D")
      @study.patient_id = params[:study][:patient_id] 
      existing_record = current_user.studies.find_by(study_uid: @study.study_uid)
      if !existing_record.nil?
        if existing_record[:patient_id] == @study.patient_id
          node.send(tmpFile.tempfile.path)
          sleep 2
          @study.num_instances = StudyTable.find_by(study_iuid: @study.study_uid )[:num_instances]
          respond_to do |format|
            if existing_record.update_attributes(:updated_at => DateTime.now, :num_instances => @study.num_instances )
              format.html {
                render :json => [@study.to_jq_upload].to_json,
                :content_type => 'text/html',
                :layout => false
              }
              format.json { render json: {files: [@study.to_jq_upload]}, status: :created, location: @study }
            else
              format.html { render action: "new" }
              format.json { render json: @study.errors, status: :unprocessable_entity }
            end
          end
        else
          flash[:danger] = "File not uploaded due to redunduncy!! Please check if the right patient profile is selected."
        end
      else
        node.send(tmpFile.tempfile.path)
        sleep 2
        @study.num_instances = StudyTable.find_by(study_iuid: @study.study_uid )[:num_instances]
        # @study.save
        respond_to do |format|
          if @study.save
            format.html {
              render :json => [@study.to_jq_upload].to_json,
              :content_type => 'text/html',
              :layout => false
            }
            format.json { render json: {files: [@study.to_jq_upload]}, status: :created, location: @study }
          else
            format.html { render action: "new" }
            format.json { render json: @study.errors, status: :unprocessable_entity }
          end
        end
      end
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

