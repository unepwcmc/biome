Promise = require('bluebird')
Config = require('../config.coffee')
NavigationComponent = require('./navigation.coffee')
ValidationComponent = require('./validation.coffee')

module.exports = class ProjectsListComponent
  TEMPLATE = require('../templates/projects_list.html.hbs')

  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(TEMPLATE())
    @$el.find('.results li').click( ->
      new NavigationComponent().show()
      new ValidationComponent().show()
    )
