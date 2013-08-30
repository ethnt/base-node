# base-node
#   file: config/middleware/authorization.coffee

exports.requiresLogin = (req, res, next) ->
  return res.redirect '/login' unless req.isAuthenticated()
  next()
  return
