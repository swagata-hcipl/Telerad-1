
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
<<<<<<< HEAD
        record.study_table.study_desc,
        StudyTable.find_by(study_iuid: record.study_uid)[:num_instances],
        record.study_table.study_datetime,
        record.updated_at,
        link_to("Comments",{:controller=>"comments", :action => "show",:id => record.id}, 'data-toggle' => "modal", 'data-target'=>"#exampleModal", :remote => true),
=======
        StudyTable.find_by(study_iuid: record.study_uid)[:study_iuid],
        StudyTable.find_by(study_iuid: record.study_uid)[:num_instances],
        StudyTable.find_by(study_iuid: record.study_uid)[:study_datetime],
        record.updated_at,
        link_to("Comments",{:controller=>"comments", :action => "show",:id => record.id}, 'data-toggle' => "modal", 'data-target'=>"#commentModal", :remote => true),
>>>>>>> 3a463a5b0a4cd368eae5801c236d0acc145d6752
        link_to("View Study", "http://localhost:8080/weasis/samples/applet.jsp?commands=%24dicom%3Aget%20-w%20http%3A//localhost%3A8080/weasis-pacs-connector/manifest%3FstudyUID%3D"+record.study_uid,  target: "_blank")
      ]
    end
  end

  def get_raw_records
    Patient.find(params[:id]).studies.where.not(study_uid: nil)
  end
end
