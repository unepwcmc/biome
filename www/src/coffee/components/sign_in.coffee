Promise = require('bluebird')
Config = require('../config.coffee')
sign_in_template = require('../templates/sign_in.html.hbs')

module.exports = class SignInComponent
  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(sign_in_template())
    @addEventListeners()

  addEventListeners: ->
    new Promise( (resolve, reject) =>
      @$el.find('form').submit( (ev) =>
        ev.preventDefault()
        $form_el = $(ev.target)

        @submitForm($form_el).then(resolve, reject)
      )
    )

  submitForm: ($form_el) ->
    new Promise( (resolve, reject) ->
      $.ajax(
        url: Config.sign_in_url,
        method: 'POST'
        headers:
          Accept: 'application/json'
        data:
          user:
            email: $form_el.find('#email').val(),
            password: $form_el.find('#password').val(),
            remember_me: 1
        success: resolve
        error: reject
      )
    )
