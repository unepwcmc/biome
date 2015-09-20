require('leaflet-usermarker')

Config = require('../config.coffee')
Store = require('../store.coffee')
LayersToolbox = require('./navigation/layers_toolbox.coffee')

module.exports = class NavigationComponent
  TEMPLATE = require('../templates/navigation.html.hbs')

  constructor: (@user, @project) ->
    @$el = $(Config.main_container)
    @layers = {}

  show: ->
    @$el.html(TEMPLATE())
    @toolbox = new LayersToolbox(@$el.find('.layers-toolbox'))

    @add_map()
    @add_markers()
    Store.set('map', @map)
    @add_event_listeners()

  add_map: ->
    L.mapbox.accessToken = Config.mapbox_token

    @map = L.mapbox.map(
      'map', Config.mapbox_layer,
      attributionControl: false, zoomControl: false
    ).setView(
      [14.5278, 41.0229], 9
    ).locate(
      watch: true,
      locate: true,
      enableHighAccuracy: true
      maxZoom: 16
    )

  add_markers: ->
    sql = new cartodb.SQL(user: 'carbon-tool')
    project_id = Store.get('project_id')
    query = "SELECT *, st_y(the_geom) as lat, st_x(the_geom) as lng FROM biome WHERE project_id = " + project_id
    sql.execute(query).done( (data) =>
      console.log(data.rows)
      for row in data.rows
        L.marker([row["lat"], row["lng"]]).addTo(@map).bindPopup(row["value"])
    ).error( (errors) ->
      console.log(errors)
    )

  add_event_listeners: ->
    @$el.find('.layers-button').click(@toolbox.toggle)

    @toolbox.on('layer-activated', (layer_id) =>
      Ramani.tileLayer(layer_id, (tileLayer) =>
        @layers[layer_id] = tileLayer.setOpacity(0.3)
        @layers[layer_id].addTo(@map)
      )
    )

    @toolbox.on('layer-deactivated', (layer_id) =>
      @map.removeLayer(@layers[layer_id])
      @layers[layer_id] = null
    )

    @map.once('locationfound', (location) =>
      @map.setView(location.latlng, 16)
      @user_marker = L.userMarker(
        location.latlng,
        accuracy: 100, smallIcon: true
      ).addTo(@map)

      @add_marker_refresh()
    )

    Store.get('header').on('validation-activated', =>
      @map.invalidateSize()
      $('.layers-button').toggle()
      $('.validation-buttons').toggle()
    )

  add_marker_refresh: ->
    @map.on('locationfound', (location) =>
      @user_marker.setLatLng(location.latlng)
      @user_marker.setAccuracy(location.accuracy)
    )
