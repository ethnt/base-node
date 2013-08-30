# base-node
#   file: app/helpers/general.coffee

module.exports = (app) ->

  marked = require 'marked'
  app.locals.marked = marked

  moment = require 'moment'
  app.locals.dateShortMon = (date) ->
    return moment(date).format 'MMM DD'
