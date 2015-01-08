  class StudyDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  # include AjaxDatatablesRails::Extensions::Kaminari
  include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator

  def_delegators :@view, :link_to

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= [
      'studies.num_instances',
      'studies.updated_at'
    ]
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= [
      # 'studies.study_table.study_desc',
      # 'studies.study_table.study_datetime'
    ]
  end

  private

  def data
    records.map do |record|
      [
        record.study_table.study_desc,
        record.num_instances,
        record.study_table.study_datetime,
        record.updated_at,
        link_to("Comments",{controller: :comments,action: :new}),
        link_to("View Study", "http://localhost:8080/weasis/samples/applet.jsp?commands=%24dicom%3Aget%20-w%20http%3A//localhost%3A8080/weasis-pacs-connector/manifest%3FstudyUID%3D"+record.study_uid)
      ]
    end
  end

  def get_raw_records
    Patient.find(params[:id]).studies.where.not(study_uid: nil)
  end
end
