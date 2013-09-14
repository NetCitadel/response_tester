# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

pollTime = 2000

callback = ->
  $("#services").load(window.location.pathname + " #services > *")
  setTimeout callback, pollTime

setTimeout callback, pollTime
