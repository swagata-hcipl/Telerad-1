table_ready = ->
  'use strict'
  # Initialize the jQuery File Upload widget:
  $("#fileupload").fileupload
    sequentialUploads: true
    filesContainer: $('#dustatus .files')
  #acceptFileTypes: '/(\.|\/)(dcm|dicom| )$/i'

  # $.getJSON $("#fileupload").prop("action"), (files) ->
  #   fu = $("#fileupload").data("blueimp-fileupload")
  #   template = undefined
  #   #        fu._adjustMaxNumberOfFiles(-files.length);
  #   # direct use console obj will cause error in IE.
  #   #        console.log(files);
  #   template = fu._renderDownload(files).appendTo($("#dustatus .files"))
  #    # Force reflow:
  #   fu._reflow = fu._transition and template.length and template[0].offsetWidth
  #   template.addClass "in"
  #   $("#loading").remove()

  oTable = $('#studiesTable').DataTable
    info: false
    processing: true
    serverSide: true
    autoWidth: false
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
  $("#fileupload").bind "fileuploadfail", (e, data) ->
    oTable.ajax.reload()
  $("#fileupload").bind "fileuploaddone", (e, data) ->
    oTable.ajax.reload()


  # Show sidebar
  showSidebar = ->
    objMain.addClass "use-sidebar"
    $('#reset_btn').show()
    $.cookie "sidebar-pref2", "use-sidebar",
      expires: 30
    return

  # Hide sidebar
  hideSidebar = ->
    objMain.removeClass "use-sidebar"
    $('#reset_btn').hide()
    $.cookie "sidebar-pref2", null,
      expires: 30
    return
  objMain = $("#main")

  # Sidebar separator
  objSeparator = $("#separator")
  objSeparator.click((e) ->
    e.preventDefault()
    if objMain.hasClass("use-sidebar")
      hideSidebar()
    else
      showSidebar()
    return
  ).css "height", objSeparator.parent().outerHeight() + "px"

  # Load preference
  objMain.removeClass "use-sidebar"  if $.cookie("sidebar-pref2") is null

  



  source = new EventSource('/upload_stream')

  source.addEventListener 'study.update', (e) ->
    study = $.parseJSON(e.data)
    console.log(study.study_uid)
    # $("#dustatus .files").appendTo
    $('#dustatus > tbody:last').append('<tr class="fade in"><td>Updated</td><td>'+study.filename+'</td><td>'+study.updated_at+'</td><td></td></tr>')

  source.addEventListener 'study.create', (e) ->
    study = $.parseJSON(e.data)
    console.log(study.study_uid)
    # $("#dustatus .files").appendTo
    $('#dustatus > tbody:last').append('<tr class="fade in"><td>Added</td><td>'+study.filename+'</td><td>'+study.updated_at+'</td><td></td></tr>')

  # source.onmessage = (event) ->
  #   alert event.data

  $('#reset_btn').click ->
    $('#dustatus').find("tr").remove()
    return

  $('#add_btn').click ->
    showSidebar()
    return

$(document).ready table_ready
$(document).on "page:load", table_ready