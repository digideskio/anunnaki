package pharoah;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'pharoah', '.execute', 'pharoah->execute($user, $chan, $msg);');
}

sub execute {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    $data[0] = '';
    my @output = `@data`;

    for my $line (@output) {
	$irc::socket->send("PRIVMSG $chan :$line\r\n");
    } 
}


1;
