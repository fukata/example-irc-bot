
/**
 * Module dependencies.
 */

var express = require('express');

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
  app.use(express.errorHandler()); 
});

// Routes

app.get('/', function(req, res){
  var irc=require('./basic_irc.js');
  var channel = '#dev';
  irc = new irc.server({'host':'HOSTNAME','port':6667,'ssl':false,'ping':true, 'nick':'NICKNAME'});
  irc.events = {
	onConnect: function (params) {
		console.log('onConnect');
	        this.enterChannel(channel);
	        this.say(channel, 'HelloWorld');
	}
  };
  irc.connect({'nick':'NICKNAME','pass':'','user':'USERNAME','real':'REALNAME'});
  res.render('index', {
    title: 'Express'
  });
});

// Only listen on $ node app.js

if (!module.parent) {
  app.listen(3000);
  console.log("Express server listening on port %d", app.address().port);
}
