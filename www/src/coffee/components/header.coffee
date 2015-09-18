Config = require('../config.coffee')
ProjectsListComponent = require('./projects_list.coffee')

module.exports = class HeaderComponent
  TEMPLATE = require('../templates/header.html.hbs')

  constructor: ->
    @$el = $('#main_header')

  show: ->
    @$el.html(TEMPLATE())
    @add_event_listener()

  add_event_listener: ->
    @menu_listener()

  menu_listener: ->
    $('.menu').on('click', (e) ->
      e.preventDefault()
      new ProjectsListComponent().show()
    )
