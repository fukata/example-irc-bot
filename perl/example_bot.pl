#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

package ExampleBot;
use base 'Bot::BasicBot';

my %conf = (
	nick => 'NICKNAME',
	username => 'USERNAME',
	server => 'SERVER',
	#port => 6667,
	#password => 'PASSWORD',
	#ssl => 1,
	channels => ['#hoge', '#foo'],
	charset => 'utf-8',
);

# when connected
sub connected {
	my $self = shift;
	print "connected\n";
	#$self->say( (who => 'NICKNAME', channel => '#hoge', body => 'Hello World') );
}

# when said
sub said {
	my ($self, $mess) = @_;
	my $body = $mess->{body};
	printf("said: message=%s, body=%s\n", $mess, $body);
	#return sprintf("Hello: %s", $body);
	# if don't say return 0
	return 0;
}

# when join channel
sub chanjoin {
	my ($self, $mess) = @_;
	printf("chainjoin: who=%s, channel=%s\n", $mess->{who}, $mess->{channel});
	return 0;
}

# when leaves channel
sub chanpart {
	my ($self, $mess) = @_;
	printf("chanpart: channel=%s, names=%s\n", $mess->{channel}, $mess->{names});
}

# when change topic
sub topic {
	my ($self, $mess) = @_;
	printf("topic: who=%s channel=%s, topic=%s\n", $mess->{who}, $mess->{channel}, $mess->{topic});
}

# when kicked from channel 
sub kicked {
	my ($self, $mess) = @_;
	printf("kicked: who=%s channel=%s, kicked=%s, reason=%s\n", $mess->{who}, $mess->{channel}, $mess->{kicked}, $mess->{reason});
}

# event called every regularly.
# The default tick is called 5 seconds after the bot starts
sub tick {
	my ($self, $mess) = @_;
	printf("tick");
	return 0;
}

__PACKAGE__->new(%conf)->run();
