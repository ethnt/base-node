/*
	base-node
		file: server.js
*/

/*
	= Appendix
		I. Dependencies and Environment
		II. Database
		III. Express
		IV. Server
*/


/*
	I. Dependencies and Environment
*/

var express  = require('express'),
    http     = require('http'),
    fs       = require('fs'),
    passport = require('passport'),
    mongoose = require('mongoose'),
    coffee   = require('coffee-script'),
    less     = require('sass')

var env    = process.env.NODE_ENV || 'development',
    config = require('./config/environment')[env],
    auth   = require('./config/middleware/authorization')


/*
	II. Database
*/

console.log('Connecting to database at ' + config.db)
mongoose.connect(config.db)

var models = __dirname + '/app/models'
fs.readdirSync(models).forEach(function (file) {
	require(models + '/' + file)
});


/*
	III. Express
*/

require('./config/passport')(passport, config)

var app = express()

require('./config/express')(app, config, passport)

require('./config/routes')(app, passport, auth)


/*
	IV. Server
*/

var port = process.env.PORT || 3000
http.createServer(app).listen(port, function(){
  console.log('Express app running on port ' + port)
});
