package qdb;

use strict;
use warnings;

BEGIN {
    triggers->add('channel', 'lord', '.qadd', 'qdb->add($user, $chan, $msg);');
}

sub add {
    my ($username, $channel, @quote) = ($_[1], $_[2], split " ", $_[3]);
    $quote[0] = '';

    if($quote[1] !~ /<(.*)>/) {
	$irc::socket->send("PRIVMSG $channel :For now this quote feature only allows <nickname> parsing\r\n");
    } else {
	open(my $qin, ">>db/qdb.db");
	print $qin "@quote";
	close($qin);

	$irc::socket->send("PRIVMSG $channel :Quote has been added to the database.\r\n");
    }
}

sub grep {
    my ($channel, @data) = ($_[1], split " ", $_[2]);

}

1;
