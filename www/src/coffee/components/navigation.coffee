Config = require('../config.coffee')
LayersControl = require('../templates/navigation.html.hbs')

module.exports = class NavigationComponent
  TEMPLATE = require('../templates/navigation.html.hbs')

  constructor: (@user, @project) ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(TEMPLATE())

    @addMap()
    @addLayersToolbox()

  addMap: ->
    L.mapbox.accessToken = Config.mapbox_token

    @map = L.mapbox.map(
      'map', Config.mapbox_layer,
      attributionControl: false, zoomControl: false
    ).setView(
      [14.5278, 41.0229], 9
    )

  addLayersToolbox: ->

