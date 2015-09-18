attachFastClick = require('fastclick')
attachFastClick(document.body)

require('mapbox.js')

SignInComponent = require('./components/sign_in.coffee')
HeaderComponent = require('./components/header.coffee')
ProjectsListComponent = require('./components/projects_list.coffee')
NavigationComponent = require('./components/navigation.coffee')

document.addEventListener('deviceready', (e) ->
  $.support.cors = true

  new SignInComponent().show()
)
