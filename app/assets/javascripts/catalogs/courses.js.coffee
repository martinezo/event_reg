# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
#  alert 'ready'
  fill_input_file_name()
  clear_input_file()
  return

#For turbolinks: http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper. Instead of $(document).ready
$(document).on "page:load", ->
#  alert 'load'
  fill_input_file_name()
  clear_input_file()
  return

fill_input_file_name = ->
  $("#catalogs_course_content_file_tag,#catalogs_course_image_file1_tag,#catalogs_course_image_file2_tag,#catalogs_course_image_file3_tag").change ->
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
