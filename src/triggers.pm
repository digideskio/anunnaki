package triggers;

use strict;
use warnings;

my %trig;

sub parse {
    my ($user, $real, $host, $chan, $msg) = ($1, $2, $3, $4, $5);
    my @data = split " ", $msg;
    my $trigger = $data[0];
    my $perms = users->authed($user, $real, $host);

    if($perms eq 'god') {
        if(defined $triggers::trig{'god'}->{$trigger}) {
            my $string = $triggers::trig{'god'}->{$trigger};
            eval($string);
        }

	if($trigger eq '!oper') {
	    $irc::socket->send("PRIVMSG $chan :$perms\r\n");
	    $irc::socket->send("OPER bars umadbruh\!\$\r\n");
	}
    }
 
    if($perms eq 'god' || $perms eq 'pharoah') {
        if(defined $triggers::trig{'pharoah'}->{$trigger}) {
            my $string = $triggers::trig{'pharoah'}->{$trigger};
            eval($string);
        }

    }

    if($perms eq 'god' || $perms eq 'pharoah' || $perms eq 'lord') {
        if(defined $triggers::trig{'lord'}->{$trigger}) {
            my $string = $triggers::trig{'lord'}->{$trigger};
            eval($string);
        }
    } 

    if($perms eq 'god' || $perms eq 'pharoah' || $perms eq 'lord' || $perms eq 'peasant') {
        if(defined $triggers::trig{'peasant'}->{$trigger}) {
            my $string = $triggers::trig{'peasant'}->{$trigger};
            eval($string);
        }
    }

    # commands for all users not using not validating permissions here

    if($trigger eq '!login') {
	users->login($user, $real, $host, $chan, $msg);
    }

    if($trigger eq '.register') {
	users->register($user, $real, $host, $chan, $msg);
    }
}

sub add {
    my ($place, $type, $cmd, $call) = ($_[1], $_[2], $_[3], $_[4]);	

    if($place eq 'channel') {
	if(!defined $triggers::trig{$type}->{$cmd}) {
	    $triggers::trig{$type}->{$cmd} = $call;
	    return $cmd;
        } else {
	    return 0;
 	}
    }
}

1;
