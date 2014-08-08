# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
fill_input_file_name = ->
  $("#catalogs_participant_upload_file1_tag,#catalogs_participant_upload_file2_tag,#catalogs_participant_upload_file3_tag").change ->
    $("#" + @id.slice(0, -4)).val $(this).val()
    return
  return

clear_input_file = ->
  $(".remove-file-button").click (event) ->
    event.preventDefault()
    $($(this).attr("name")).val ""
    $($(this).attr("name") + "_tag").val ""
    return
  return