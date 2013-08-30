# base-node
#   file: app/controllers/user.coffee

mongoose = require 'mongoose'
_ = require 'underscore'

User = mongoose.model 'User'


# GET /login
exports.login = (req, res) ->
  res.render 'users/login',
    title: 'Login'
    message: req.flash 'error'
  return

# GET /logout
exports.logout = (req, res) ->
  req.logout()
  res.redirect '/'
  return

# GET /users
exports.index = (req, res) ->
  User.list (err, users) ->
    res.render 'users/index',
      users: users
      message: req.flash 'notice'
    return

# GET /users/new
exports.new = (req, res) ->
  res.render 'users/new',
    user: new User({})
  return

# POST /users/create
exports.create = (req, res) ->
  user = new User req.body
  user.save (err) ->
    if err
      res.render 'users/new',
        errors: err.errors
        user: user

    res.redirect '/users'
    return

# GET /users/:id
exports.user = (req, res, next, id) ->
  User.findById(id).exec (err, user) ->
    return next err if err
    return next new Error 'Failed to load user' if not user

    req.profile = user
    next()
    return
  return

# GET /users/:id/edit
exports.edit = (req, res) ->
  res.render 'users/edit',
    user: req.profile
  return

# PUT /users/:id
exports.update = (req, res) ->
  user = req.profile

  user.name = req.body.name
  user.username = req.body.username
  user.email = req.body.email

  user.password = req.body.password if req.body.password

  user.save (err) ->
    if err
      console.log err

      res.render 'users/edit',
        user: user
        errors: err.errors
    else
      req.flash 'notice', 'User was successfully updated'
      res.redirect '/users'
    return
  return

# DELETE /users/:id/destroy
exports.destroy = (req, res) ->
  user = req.profile

  user.remove (err) ->
    req.flash 'notice', 'User ' + user.name + ' was successfully deleted.'
    res.redirect '/users'

  return
