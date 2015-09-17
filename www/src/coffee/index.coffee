SignInComponent = require('./components/sign_in.coffee')
ProjectsListComponent = require('./components/projects_list.coffee')

document.addEventListener('deviceready', (e) ->
  $.support.cors = true

  sign_in = new SignInComponent()
  sign_in.show()

  #projects_list = new ProjectsListComponent()
  #projects_list.show()
)
