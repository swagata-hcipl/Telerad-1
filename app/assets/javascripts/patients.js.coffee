table_ready = ->
  'use strict'
  # Initialize the jQuery File Upload widget:
  $("#fileupload").fileupload sequentialUploads: true
  #acceptFileTypes: '/(\.|\/)(dcm|dicom| )$/i'
  # $("#fileupload").bind "fileuploaddone", (e, data) ->
  #   console.log(data.result)
  #   oTable.ajax.reload()

  $.getJSON $("#fileupload").prop("action"), (files) ->
    fu = $("#fileupload").data("blueimp-fileupload")
    template = undefined
    #        fu._adjustMaxNumberOfFiles(-files.length);
    # direct use console obj will cause error in IE.
    #        console.log(files);
    template = fu._renderDownload(files).appendTo($("#fileupload .files"))
     # Force reflow:
    fu._reflow = fu._transition and template.length and template[0].offsetWidth
    template.addClass "in"
    $("#loading").remove()

  oTable = $('#studiesTable').DataTable
    info: false
    processing: true
    serverSide: true
    ajax: $('#studiesTable').data('source')
    pagingType: 'full_numbers'
    language: {
      "sSearch": "Filter Studies"
    }
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>Tt<'row-fluid'<'span6'i><'span6'p>>",
    tableTools: {
      sSwfPath: "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf"
      "aButtons": [
        "copy",
        "print",
        {
          "sExtends":    "collection",
          "sButtonText": 'Save <span class="caret" />',
          "aButtons":    [ "csv", "xls" ]
        }
      ]
    }
  return

$(document).ready table_ready

$(document).on "page:load", table_ready