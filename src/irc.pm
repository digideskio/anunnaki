package irc;

use strict;
use warnings;
use IO::Socket::INET;


sub new {
    my ($server, $ident, $channels) = @_;
    
    our $socket = IO::Socket::INET->new(PeerAddr => $server,
                                        PeerPort => 6667,
                                        Proto => 'tcp') or die " Could not establish connection to " . $server ."\n";

    print $socket "USER $ident $ident $ident $ident :$ident\n";
    print $socket "NICK $ident\n";

# the auto join for the bot seems to parse differently
# between inspircd and unreal.. for inspircd uncomment these lines

#    sleep 3;
#    print $socket "JOIN $channels\r\n";

# uncomment to fork into background
#    irc->fork();

    while(my $data = <$socket>) {
        if($data =~ m/^PING (.*?)$/gi) {
            $socket->send("PONG $1\n");
        }

	# identify with nickserv if bot is using registered nick
	if($data =~ m/^:NickServ!Services\@MagicIRC.Net NOTICE anunnaki :please choose a different nick./) {
   	    $socket->send("PRIVMSG NickServ :identify lolwut!#\r\n");
	}

	# if using inspircd comment out this if statement and use the other one above
        if($data =~ /:$ident/) {
	     $socket->send("JOIN $channels\r\n");

        }

        if($data =~ /:(.*?)!(.*?)@(.*?) (?:PRIVMSG|NOTICE) (.*?) :(.*?)$/) {
	    triggers->parse($1, $2, $3, $4, $5);
        }

    print $data;
    }
}

sub fork {
    my $pid = fork();

    if($pid != 0) {
	open(my $pidfile, ">", "db/anunnaki.pid");
	print $pidfile "$pid\n";
	close($pidfile);
	print "Forked to background running as $pid\n";
	exit 0;
    }
}

1;
