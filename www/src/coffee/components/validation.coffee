Config = require('../config.coffee')
validation_template = require('../templates/validation.html.hbs')

module.exports = class ValidationComponent
  constructor: ->
    @$el = $('#validation_form')

  show: ->
    @$el.html(validation_template())
    @add_event_listener()

  add_event_listener: ->
   #@submit_form()

  submit_form: ->
    $('#validators').submit( (e) ->
      e.preventDefault()
      data = $(this).serialize()
      $.ajax({
        url: ''
        method: 'POST'
        data: data
        success: console.log
        error: console.error
      })
    )

