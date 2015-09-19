module.exports = class UICorrections
  @apply: ->
    attachFastClick = require('fastclick')
    attachFastClick(document.body)
