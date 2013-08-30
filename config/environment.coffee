# base-node
#   file: config/environment.coffee

module.exports =
  development:
    app:
      name: 'base-node'
    root: require('path').normalize(__dirname + '/..')
    db: process.env.MONGOHQ_URI || 'mongodb://localhost/base-node'
