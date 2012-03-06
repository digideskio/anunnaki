package irc;

use strict;
use warnings;
use IO::Socket::INET;


sub new {
    my ($server, $ident, $channels) = @_;
    
    our $socket = IO::Socket::INET->new(PeerAddr => $server,
                                        PeerPort => 6667,
                                        Proto => 'tcp') or die "Could not establish connection to " . $server ."\n";

    print $socket "USER $ident $ident $ident $ident :$ident\n";
    print $socket "NICK $ident\n";
    
    while(my $data = <$socket>) {
        if($data =~ m/^PING (.*?)$/gi) {
            $socket->send("PONG $1\n");
        }

        if($data =~ /^:$ident/) {
            $socket->send("JOIN $channels\r\n");
        }

        if($data =~ /:(.*?)!(.*?)@(.*?) (?:PRIVMSG|NOTICE) (.*?) :(.*?)$/) {
            my ($user, $real, $host, $chan, $msg) = ($1, $2, $3, $4, $5);

	    if($msg =~ m/^!gamble/) {
		jewgolds->gamble($socket, $user, $chan);
	    }

	    if($msg =~ m/^!jewgolds/) {
		jewgolds->amount($socket, $user, $chan);	
	    }

        }
	
    print $data;
    }
}

1;
