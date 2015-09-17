Config = require('../config.coffee')
projects_list_template = require('../templates/projects_list.html.hbs')

module.exports = class ProjectsListComponent
  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(projects_list_template())
