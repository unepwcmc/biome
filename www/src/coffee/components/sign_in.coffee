Promise = require('bluebird')
Config = require('../config.coffee')
ProjectsListComponent = require('./projects_list.coffee')
HeaderComponent = require ('./header.coffee')

module.exports = class SignInComponent
  TEMPLATE = require('../templates/sign_in.html.hbs')

  constructor: () ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(TEMPLATE())
    @add_event_listeners()

  add_event_listeners: ->
    @$el.find('form').submit( (ev) =>
      ev.preventDefault()
      $form_el = $(ev.target)

      @submit_form($form_el, (user) ->
        new HeaderComponent().show()
        new ProjectsListComponent(user).show()
      )
    )

  submit_form: ($form_el, next) ->
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
      success: next
      error: console.error
    )
