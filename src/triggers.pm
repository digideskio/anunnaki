package triggers;

use strict;
use warnings;
use Term::ANSIColor;

my %trig;

sub parse {
    my ($user, $real, $host, $chan, $msg) = ($1, $2, $3, $4, $5);
    my @data = split " ", $msg;
    my $trigger = $data[0];
    my $perms = users->authed($user, $real, $host);


#    print "$chan:($perms):<$user> $msg\r\n";
#    print "\e[1;34m".$chan.":\e[0m\e[1;31m (".$perms."):\e[0m\e[1;32m<".$user.">\e[0m\e[1;37m ".$msg."\e[0m";
    print color("yellow"), "$chan:"; print color("reset");
    print color("red"), "($perms):"; print color("reset");         
    print color("green"), "<$user> "; print color("reset");
    print color("white"), "$msg\r\n"; print color("reset");

    if($perms eq 'god') {
        if(defined $triggers::trig{'god'}->{$trigger}) {
            my $string = $triggers::trig{'god'}->{$trigger};
            eval($string);
        }

	if($trigger eq '!perms') {
	    users->chperms($user, $chan, $msg);
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

    if($trigger =~ m/http:/) {
	open(my $uin, ">>db/urls.txt");
	print $uin "<$user> $msg\n";
	close($uin);
    }

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
