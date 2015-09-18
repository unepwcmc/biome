Config = require('../config.coffee')
validation_template = require('../templates/validation.html.hbs')


module.exports = class ValidationComponent
  constructor: ->
    @$el = $(Config.main_container)

  show: ->
    @$el.html(validation_template())
    
