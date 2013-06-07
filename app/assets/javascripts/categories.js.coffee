# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#start_datetime_textfield').datetimepicker({timeFormat: 'hh:mm:ss', dateFormat: 'yy-mm-dd'});
  $('#end_datetime_textfield').datetimepicker({timeFormat: 'hh:mm:ss', dateFormat: 'yy-mm-dd'});
