Config = require('../config.coffee')
Store = require('../store.coffee')
EventEmitter = require('events')
ProjectsListComponent = require('./projects_list.coffee')

module.exports = class HeaderComponent extends EventEmitter
  TEMPLATE = require('../templates/header.html.hbs')

  constructor: ->
    @$el = $('#main_header')
    Store.set('header', @)

  show: ->
    @$el.html(TEMPLATE())
    @add_event_listener()

  add_event_listener: ->
    @menu_listener()
    @validation_mode_listener()

  menu_listener: ->
    $('.menu').on('click', (e) ->
      e.preventDefault()
      new ProjectsListComponent().show()
    )

  validation_mode_listener: ->
    $('.edit').on('click', (e) =>
      e.preventDefault()
      $('#validation_form').slideToggle( =>
        @emit('validation-activated')
      )
    )
