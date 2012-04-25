# basic irc command module
# @author bars
package basic;

use strict;
use warnings;

BEGIN {

    triggers->add('channel', 'lord', '!voice', 'basic->voice($user, $chan, $msg);');
    triggers->add('channel', 'lord', '!op', 'basic->op($user, $chan, $msg);');
    triggers->add('channel', 'lord', '!hop', 'basic->hop($user, $chan, $msg);');
    triggers->add('channel', 'pharoah', '!protect', 'basic->protect($user, $chan, $msg);');
    triggers->add('channel', 'god', '!me', 'basic->me($user, $chan, $msg);');
    triggers->add('channel', 'god', '!cycle', 'basic->cycle($user, $chan, $msg);');
    triggers->add('channel', 'god', '!owner', 'basic->owner($user, $chan, $msg);');
    triggers->add('channel', 'god', '!join', 'basic->join($user, $chan, $msg);');
    triggers->add('channel', 'god', '!part', 'basic->part($user, $chan, $msg);');
    triggers->add('channel', 'god', '!kick', 'basic->kick($user, $chan, $msg);');
    triggers->add('channel', 'god', '!kban', 'basic->kban($user, $chan, $msg);');
    triggers->add('channel', 'god', '!nick', 'basic->nick($user, $chan, $msg);');
}

sub voice {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    $data[0] = '';

    if($data[1] eq 'up') {
        if($data[2]) {
            $irc::socket->send("MODE $chan +v $data[2]\r\n");
        } else {
	    $irc::socket->send("PRIVMSG $chan :Usage: !voice (up/down) <username>\r\n"); 
	}
    }elsif($data[1] eq 'down') {
	if($data[2]) {
	    $irc::socket->send("MODE $chan -v $data[2]\r\n");
	} else {
	    $irc::socket->send("PRIVMSG $chan :Usage: !voice (up/down) <username>\r\n");
	}
    }elsif(!$data[1]) {
	$irc::socket->send("PRIVMSG $chan :Usage: !voice (up/down) <username>\r\n");
    }
}

sub join {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $join = $data[1];
    $irc::socket->send("JOIN $join\r\n");
}

sub part {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $part = $data[1];
    $irc::socket->send("PART $part\r\n");
}

sub kick {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $kick = $data[1];
#    my $reason = split " ", @data;
    
    $irc::socket->send("KICK $chan $kick :@data\r\n");
}

sub kban {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
}

sub nick {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $new = $data[1];

    $irc::socket->send("NICK $new\r\n");
}
    

1;
