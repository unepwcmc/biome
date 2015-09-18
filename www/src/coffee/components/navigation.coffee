Config = require('../config.coffee')
navigation_template = require('../templates/navigation.html.hbs')

module.exports = class NavigationComponent
  constructor: (@user, @project) ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(navigation_template())
    @addMap()

  addMap: ->
    L.mapbox.accessToken = Config.mapbox_token

    @map = L.mapbox.map(
      'map', Config.mapbox_layer,
      attributionControl: false, zoomControl: false
    ).setView(
      [14.5278, 41.0229], 9
    )
