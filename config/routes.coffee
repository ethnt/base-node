# base-node
#   file: config/routes.coffee

# = Appendix
#   I. Core
#   II. Users

module.exports = (app, passport, auth) ->

  #
  # I. Core
  #
  core = require '../app/controllers/core'
  app.get '/', core.index

  #
  # II. Users
  #
  users = require '../app/controllers/users'
  app.get '/login', users.login

  app.post '/login', passport.authenticate('local',
    failureRedirect: '/login'
    failureFlash: true),

    (req, res) ->
      res.redirect '/'
      return

  app.get '/logout', users.logout

  app.get '/users', auth.requiresLogin, users.index
  app.get '/users/new', auth.requiresLogin, users.new
  app.post '/users', auth.requiresLogin, users.create
  app.get '/users/:id/edit', auth.requiresLogin, users.edit
  app.put '/users/:id', auth.requiresLogin, users.update
  app.get '/users/:id/destroy', auth.requiresLogin, users.destroy

  app.param 'id', users.user

  return
