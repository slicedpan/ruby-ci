# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(() ->
  $('a.create_branch_link').click((e) ->
    console.log('blak')
    e.preventDefault()
    el = $(this)
    el.parent().find('form').submit()
  )
)