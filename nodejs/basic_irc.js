var irc = exports;
var server = irc.server = require('./irc.js').server;
var _ = require('underscore');

server.prototype.events = {};
server.prototype.checkEvent = function(ev_name) {
	if (!this.events) {
		return false;
	}
	if (ev_name in this.events && typeof this.events[ev_name] == "function") {
		return true;
	} else {
		return false;
	}
}

//register some event functions.
server.prototype.hooks = function(events) {
	var self = this;
	_.each(events, function(callback, eventName) {
		self.events[eventName] = callback;
	});
};

//register a event function.
server.prototype.hook = function(eventName, callback) {
	this.events[eventName] = callback;
};

var eventNames = [
	'onConnect', 'onDisconnect', 'onData', 'onTooManyChannels', 'onNicknameInUse',
	'onChannelMaker', 'onNick', 'onJoin', 'onPart', 'onQuit', 'onPrivateMessage',
	'onMode', 'onMOTD', 'onNotice', 'onUserList', 'onNumerical', 'onPing',
	'onSecureConnect', 'onError'
];

_.each(eventNames, function(eventName) {
	var parentEventName = '_p_' + eventName;
	server.prototype[parentEventName] = server.prototype[eventName];
	server.prototype[eventName] = function() {
		this[parentEventName].apply(this, arguments);
		if (this.checkEvent(eventName))
			this.events[eventName].apply(this, arguments);
	}
});
