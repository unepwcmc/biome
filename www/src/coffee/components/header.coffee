Config = require('../config.coffee')

module.exports = class HeaderComponent
  TEMPLATE = require('../templates/header.html.hbs')

  constructor: ->
    @$el = $('#main_header')

  show: ->
    @$el.html(TEMPLATE())
