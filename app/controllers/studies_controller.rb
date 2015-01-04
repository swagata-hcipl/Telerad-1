class StudiesController < ApplicationController
  
  def new
  	# @study = Study.new
  	# respond_to do |format|
   #    format.html # new.html.erb
   #    format.json { render json: @study }
   #  end
  end

  def create
    uploaded_io = params[:study][:dicom_file_upload]
    debugger
    # node = DClient.new("10.1.25.200", 104)
    # uploaded_io.each do |tmpFile|
    #   node.send(tmpFile.tempfile)
    # end
    # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
  end

  private
    def current_patient
      Patient.where(id: params[:id])
    end

end