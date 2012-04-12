package triggers;

use strict;
use warnings;

my %trig;

sub parse {
    my ($user, $real, $host, $chan, $msg) = ($1, $2, $3, $4, $5);

    # main triggers for hardcoded commands
    # basic bot commands included 
    # ! trigger
 
    if($msg =~ m/^!gamble/) {
        jewgolds->gamble($user, $chan);
    }

    if($msg =~ m/^!jewgolds/) {
        jewgolds->amount($user, $chan);
    }

    if($msg =~ m/^!campaign/) {
        vote->campaign($user, $chan);
    }

    if($msg =~ m/^!vote/) {
       vote->parse($user, $chan, $msg);
    }

    # . trigger

    if($msg =~ m/^.diss/) {
        annoy->insult($user, $chan, $msg);
    }

    if($msg =~ m/^.ddos/) {
        annoy->ddos($user, $chan, $msg);
    }

    if($msg =~ m/^.retard/) {
        annoy->retard($user, $chan, $msg);
    }

    if($msg =~ m/^.register/) {
	users->register($user, $real, $host, $chan, $msg);
    }
}

sub add {
    my ($place, $type, $cmd, $call) = ($_[1], $_[2], $_[3], $_[4]);	

    if($place eq 'channel') {
        $triggers::trig{$type}->{$cmd} = $call;
        return $cmd;
    }
}

1;
