attachFastClick = require('fastclick')
attachFastClick(document.body)

require('mapbox.js')

SignInComponent = require('./components/sign_in.coffee')
ProjectsListComponent = require('./components/projects_list.coffee')
NavigationComponent = require('./components/navigation.coffee')

document.addEventListener('deviceready', (e) ->
  $.support.cors = true

  new SignInComponent().show().then( (user) ->
    new ProjectsListComponent(user).show()
  ).then( (project) ->
    new NavigationComponent(null, project).show()
  ).catch(
    console.error
  )
)
