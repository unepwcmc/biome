Promise = require('bluebird')
Config = require('../config.coffee')

module.exports = class ProjectsListComponent
  TEMPLATE = require('../templates/projects_list.html.hbs')

  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(TEMPLATE())

    new Promise( (resolve, reject) =>
      @$el.find('.results li').click(resolve)
    )
