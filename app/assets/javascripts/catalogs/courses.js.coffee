# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
#  alert 'ready'
  color_picker()
  set_colorpickers()
  return

#For turbolinks: http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper. Instead of $(document).ready
$(document).on "page:load", ->
#  alert 'load'
  color_picker()
  set_colorpickers()
  return

color_picker = ->
  # Fill the text box just if the color was set using the picker, and not the colpickSetColor function.
  $(".colorpicker").colpick(
    layout: "hex"
    submit: 0
    colorScheme: "dark"
    onChange: (hsb, hex, rgb, el, bySetColor) ->
      $(el).css "border-color", "#" + hex
      $(el).val hex  unless bySetColor
      return
  ).keyup ->
    $(this).colpickSetColor @value
    return
  return

set_colorpickers = ->
  $(".colorpicker").each ->
    $(this).css "border-right-color", "#" + $(this).val()
    return
  return