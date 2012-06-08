# thread support for multiple server connections
# support also added for linking to unreal ircd
package server;

use strict;
use warnings;
use IO::Socket::INET;
use threads;
use Term::ANSIColor;

our (%main, %conn, $servsock);


BEGIN {
    triggers->add('channel', 'god', '.serv', 'server->start($chan, $msg);');
    triggers->add('channel', 'god', '.bot', 'server->bot($chan, $msg);');    
#    triggers->add('channel', 'god', '.clone', 'server->clone($chan, $msg);');
}

#sub clone {
#    my($chan, @data) = ($_[1], split " ", $_[2]);
#    my ($i, $max) = (0, 1);

#    $data[0] = '';
#    $conn{'chan'} = $chan;
#    $conn{'server'} = $data[2];
#    $conn{'nick'} = $data[3];
#    $conn{'channels'} = $data[4];

#    while($i < $maxnum) {
#        $main{"threads:$data[1]"} = threads->create(\&cserv, $data[1], $i);
#        $main{"threads:$data[1]"} = threads->detach();
#	sleep 1 if $maxnum <= 20;
#	$i++;
#    }
#}

sub bot {
    my($chan, @data) = ($_[1], split " ", $_[2]);
    $data[0] = '';
    $conn{'chan'} = $chan;
#    $irc::socket->send("PRIVMSG $chan :$data[2] $data[3] $data[4]\r\n");
    $conn{'server'} = $data[2];
    $conn{'nick'} = $data[3];
    $conn{'channels'} = $data[4];

#    $main{"threads:$data[1]"} = threads->create(\&bserv, $data[1], $conn{$_[1]}, $conn{$_[2]}, $conn{$_[3]}, $conn{$_[4]});
    $main{"threads:$data[1]"} = threads->create(\&bserv, $data[1]);
    $main{"threads:$data[1]"} = threads->detach();
}

sub start {
    my ($chan, @data) = ($_[1], split " ", $_[2]);
    $conn{$_[1]} = $chan;
    $conn{'arg'} = $data[2];
    $conn{'cmd'} = shift(@data);

    $main{"threads:$data[1]"} = threads->create(\&serv, $data[1], $conn{$_[1]});
    $main{"threads:$data[1]"} = threads->detach();
}

sub serv {
    $conn{$_[0]} = new IO::Socket::INET(PeerAddr => '174.34.147.216', PeerPort => '62201', Proto => 'tcp', Timeout => '10');
    $conn{$_[0]}->send("PASS test\r\n");
    $conn{$_[0]}->send("SERVER anunnaki.core 1 :core anunnaki server\r\n");
    #$conn{$_[0]}->send("TOPIC #Main :anunnaki gonna come rape jonathan and he gonna like it\r\n");
    
    while(my $sdata = $conn{$_[0]}->getline) {
        $conn{$_[0]}->send("PONG $1\r\n") if ($sdata =~ /^PING (.*)$/i);
	print color("bold red"), "Anunnaki Server Output->";
	print color("bold white"), "$sdata";
	$irc::socket->send("PRIVMSG $conn{$_[1]} :\x02Anunnaki Server Output->\x02$sdata\r\n");

	open(my $log, ">>db/server.log");
	print $log "$sdata";
	close($log);
    }
}

sub bserv {
    $conn{$_[0]} = new IO::Socket::INET(PeerAddr => $conn{'server'}, PeerPort => '6667', Proto => 'tcp', Timeout => '10') or $irc::socket->send("PRIVMSG $conn{'chan'} :Could not connect to $conn{'server'}\r\n");
    $conn{$_[0]}->send("USER $conn{'nick'} $conn{'nick'} $conn{'nick'} $conn{'nick'} :$conn{'nick'}\r\n");
#    $conn{$_[0]}->send("USER $botnick $botnick $botnick $botnick :$botnick\r\n");
    $conn{$_[0]}->send("NICK $conn{'nick'}\r\n");

    while(my $bdata = $conn{$_[0]}->getline) {
	if($bdata =~ m/^PING (.*?)$/gi) {
            $conn{$_[0]}->send("PONG $1\n");
        }

        if($bdata =~ /:$conn{'nick'}/) {
             $conn{$_[0]}->send("JOIN $conn{'channels'}\r\n");
        }

        if($bdata =~ /:(.*?)!(.*?)@(.*?) (?:PRIVMSG|NOTICE) (.*?) :(.*?)$/) {
	    my ($user, $real, $host, $chan, $msg) = ($1, $2, $3, $4, $5);
	    my @params = split(" ", $msg);
	    my $cmd = shift(@params);

            $irc::socket->send("PRIVMSG $conn{'chan'} :\x02$conn{'server'}\x02: ($conn{'channels'})<$user> $msg\r\n");		
#	    $irc::socket->send("PRIVMSG $conn{'channels'} :($conn{'chan'}) <$user> $msg\r\n");

	    if($cmd eq '!raw') {
		$conn{$_[0]}->send(@params);	
	    }
        }

    }
}   

#sub cserv {
#    $conn{$_[0]} = new IO::Socket::INET(PeerAddr => $conn{'server'}, PeerPort => '6667', Proto => 'tcp', Timeout => '10') or $irc::socket->send("PRIVMSG $conn{'chan'} :Unable to connect to $conn{'server'}\r\n");
#    $conn{$_[0]}->send("USER $conn{'nick'} 8 * :". int(rand(5000)) . "\r\n");
#    $conn{$_[0]}->send("NICK $conn{'nick'}\r\n");

#    while(my $bdata = $conn{$_[0]}->getline) {
#        if($bdata =~ m/^PING (.*?)$/gi) {
#            $conn{$_[0]}->send("PONG $1\n");
#        }

#        if($bdata =~ /:$conn{'nick'}/) {
#             $conn{$_[0]}->send("JOIN $conn{'channels'}\r\n");
#        }

#        if($bdata =~ /:(.*?)!(.*?)@(.*?) (?:PRIVMSG|NOTICE) (.*?) :(.*?)$/) {
#            my ($user, $real, $host, $chan, $msg) = ($1, $2, $3, $4, $5);
#            $irc::socket->send("PRIVMSG $conn{'chan'} :\x02$conn{'server'}\x02: ($conn{'channels'})<$user> $msg\r\n");
#        }

#    }
#}


1;

