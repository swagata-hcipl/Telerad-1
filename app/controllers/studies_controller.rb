require 'dicom'
require 'zip'
require 'tempfile'
include DICOM

class StudiesController < ApplicationController

  include ActionController::Live
  
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
    response.headers['Content-Type'] = 'text/event-stream'

    @study = current_user.studies.new
    uploaded_io = params[:study][:upload]

    # uploaded_io.each do |tmpFile|
    if uploaded_io.content_type.match('application/octet-stream')
      upload(uploaded_io.original_filename, uploaded_io.tempfile.path)
    elsif uploaded_io.content_type.match('application/zip')
      Zip::File.open(uploaded_io.tempfile.path) do |zip_file| 
        zip_file.each do |entry|
          if entry.ftype.to_s.match(/directory/)

          else
            filepath = "/tmp/" + SecureRandom.hex
            entry.extract(filepath)
            upload(entry.name.split('/').last, filepath)
          end
        end
      end
    else
      flash.now[:danger] = "Invalid file Format"
      redirect_to "patients/show/#{params[:study][:patient_id] }"
    end
    # end
    render nothing: true
  end

  # def upload_stream
  #   response.headers['Content-Type'] = 'text/event-stream'
  #   sse = SSE.new(response.stream)
  #   last_updated = current_user.studies.last_updated.first
  #   # if recently_changed? last_updated
  #     begin
  #       # sse.write(last_updated, event: 'results')
  #       sse.write({:time => DateTime.now})
  #     rescue IOError
  #       # When the client disconnects, we'll get an IOError on write
  #     ensure
  #       sse.close
  #     end
  #   # end
  #   render nothing: true
  # end

  private
    def current_patient
      @patient = Patient.where(id: params[:id])
    end

    def studies_params
      params.require(:study).permit(:patient_id, :user_id, :study_uid, :created_at, :updated_at)
    end

    def upload (filename, path)
      node = DClient.new("192.168.1.13", 11112, ae: "HIPL", host_ae: "DCM4CHEE")
      dcm = DObject.read(path)
      @study.study_uid = dcm.value("0020,000D")
      @study.patient_id = params[:study][:patient_id] 
      existing_record = current_user.studies.find_by(study_uid: @study.study_uid)
      if !existing_record.nil?
        if existing_record[:patient_id] == @study.patient_id
          debugger
          if !node.echo.nil?
            node.send(path)
            # respond_to do |format|
            if existing_record.update_attributes(:updated_at => (time = DateTime.now))
              study = JSON.parse(@study.to_json)
              study["filename"] = filename
              study["updated_at"] = time.strftime("%Y-%m-%d %H:%M:%S")
              $redis.publish('study.update', study.to_json)
             #  format.html {
             #    render :json => [@study.to_jq_upload].to_json, :content_type => 'text/html', :layout => false
             #  }
             #  format.json { 
             #   render json: {files: [@study.to_jq_upload]}, status: :created, location: @study 
             # }
            else
              flash[:danger] = "Connectivity problem"
              # format.html { render "patients/show" }
              # format.json { render json: @study.errors, status: :unprocessable_entity }
            end
          else
            debugger
          end
          # end
        else
          flash[:danger] = "File not uploaded due to redunduncy!! Please check if the right patient profile is selected."
        end
      else
        node.send(path)
        # respond_to do |format|
          if @study.save
            study = JSON.parse(@study.to_json)
            study["filename"] = filename
            $redis.publish('study.create', study.to_json)
            # format.html {
            #   render :json => [@study.to_jq_upload].to_json,
            #   :content_type => 'text/html',
            #   :layout => false
            # }
            # format.json { render json: {files: [@study.to_jq_upload]}, status: :created, location: @study }
          else
            flash[:danger] = "Connectivity problem"
            # format.html { render "patients/show" }
            # format.json { render json: @study.errors, status: :unprocessable_entity }
          end
        # end
      end
    end
    def recently_changed? last_study
      last_study.created_at > 5.seconds.ago or
        last_study.updated_at > 5.seconds.ago
    end

end