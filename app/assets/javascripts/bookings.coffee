# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#booking_deliveryoption_id").bind
    change: ->
      val = @.value
      $("#del_info").html ->
        switch val
          when "1" then ""
          when "2" then "Abholung der Urne durch Angehörige immer Mo - Fr zwischen 10:00 und 11:00 Uhr"
          when "3" then "Bei Postversand der Urne muss die Anlieferung des Sarges bis spätestens 9:00 Uhr (Tag der Kremation) erfolgen."
          when "4" then ""
