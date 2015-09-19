require('mapbox.js')

SignInComponent = require('./components/sign_in.coffee')
HeaderComponent = require('./components/header.coffee')
ProjectsListComponent = require('./components/projects_list.coffee')
NavigationComponent = require('./components/navigation.coffee')
UICorrections = require('./lib/ui_corrections.coffee')

document.addEventListener('deviceready', (e) ->
  $.support.cors = true

  UICorrections.apply()
  new SignInComponent().show()
)
