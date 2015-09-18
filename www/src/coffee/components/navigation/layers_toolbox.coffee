module.exports = class LayersToolbox
  TEMPLATE = require('../templates/navigation/layers_toolbox.html.hbs')

  constructor: (@$el) ->

  show: ->
    @$el.html(TEMPLATE())

