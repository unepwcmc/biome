SignInComponent = require('./components/sign_in.coffee')

document.addEventListener('deviceready', (e) ->
  $.support.cors = true

  sign_in = new SignInComponent()
  sign_in.show()
)
