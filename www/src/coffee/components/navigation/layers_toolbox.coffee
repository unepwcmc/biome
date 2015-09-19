EventEmitter = require('events')

module.exports = class LayersToolbox extends EventEmitter
  TEMPLATE = require('../../templates/navigation/layers_toolbox.html.hbs')

  constructor: (@$el) ->
    @$el.html(TEMPLATE())
    @add_event_listeners()

  add_event_listeners: ->
    emitter = @

    @$el.find('button').click( (ev) ->
      $el = $(@)

      if($el.hasClass('active'))
        emitter.emit('layer-deactivated', $(@).data('layer-id'))
        $el.removeClass('active')
      else
        emitter.emit('layer-activated', $(@).data('layer-id'))
        $el.addClass('active')
    )

  show: => @$el.slideShow()
  hide: => @$el.slideHide()
  toggle: => @$el.slideToggle()
