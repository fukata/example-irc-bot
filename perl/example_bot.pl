#!/usr/bin/env perl

use strict;
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
	#$self->say( (who => 'f_bot', channel => '#eng', body => 'Hello World') );
}

# when said
sub said {
	my $self = shift;
	my $message = shift;
	my $body = $message->{body};
	printf("said: message=%s, body=%s\n", $message, $body);
	#return sprintf("Hello: %s", $body);
	# if don't say return 0
	return 0;
}

# when join channel
sub chanjoin {
	my $self = shift;
	my $mess = shift;
	printf("chainjoin: who=%s, channel=%s\n", $mess->{who}, $mess->{channel});
	return 0;
}

# when leaves channel
sub chanpart {
	my $self = shift;
	my $mess = shift;
	printf("chanpart: channel=%s, names=%s\n", $mess->{channel}, $mess->{names});
}

# when change topic
sub topic {
	my $self = shift;
	my $mess = shift;
	printf("topic: who=%s channel=%s, topic=%s\n", $mess->{who}, $mess->{channel}, $mess->{topic});
}

# when kicked from channel 
sub kicked {
	my $self = shift;
	my $mess = shift;
	printf("kicked: who=%s channel=%s, kicked=%s, reason=%s\n", $mess->{who}, $mess->{channel}, $mess->{kicked}, $mess->{reason});
}

sub tick {
	my $self = shift;
	my $mess = shift;
	printf("tick");
	return 0;
}

ExampleBot->new(%conf)->run();
