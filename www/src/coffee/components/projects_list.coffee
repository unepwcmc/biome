Promise = require('bluebird')
Config = require('../config.coffee')
Store = require('../store.coffee')
NavigationComponent = require('./navigation.coffee')
ValidationComponent = require('./validation.coffee')

module.exports = class ProjectsListComponent
  TEMPLATE = require('../templates/projects_list.html.hbs')

  constructor: ->
    @$el = $(Config.main_container)
    @$el.removeClass("no-header")

  show: ->
    @$el.html(TEMPLATE())
    @$el.find('.results li').click( ->
      Store.set('project_id', $(@).data('project-id'))
      new NavigationComponent().show()
      new ValidationComponent().show()
    )
