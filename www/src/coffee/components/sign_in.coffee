Config = require('../config.coffee')
sign_in_template = require('../templates/sign_in.html.hbs')

module.exports = class SignInComponent
  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(sign_in_template())
    @addEventListeners()

  addEventListeners: ->
    @$el.find('form').submit( (ev) =>
      ev.preventDefault()
      $form_el = $(ev.target)

      @submitForm($form_el)
    )

  submitForm: ($form_el) ->
    $.post(Config.sign_in_url, {
      user: {
        email: $form_el.find('#email').val(),
        password: $form_el.find('#password').val(),
        remember_me: 1
      }
    }, (user_data) ->
      console.log user_data
    )
