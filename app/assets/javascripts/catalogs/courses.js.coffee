# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#catalogs_course_content_file').change( () ->
    $('#' + this.id + '_str').val($(this).val()))
    #$('#catalogs_course_content_file_str').val($('#catalogs_course_content_file').val()))

  $(".clear_file").click (event) ->
    event.preventDefault()
    $($(this).val()).val ''
    $($(this.value + "_str")).val ''
    return
