Promise = require('bluebird')
Config = require('../config.coffee')

module.exports = class SignInComponent
  TEMPLATE = require('../templates/sign_in.html.hbs')

  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(TEMPLATE())
    @add_event_listeners()

  add_event_listeners: ->
    new Promise( (resolve, reject) =>
      @$el.find('form').submit( (ev) =>
        ev.preventDefault()
        $form_el = $(ev.target)

        @submit_form($form_el).then(resolve, reject)
      )
    )

  submit_form: ($form_el) ->
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
