package qdb;

# need to incorperate topquotes, random quote display, vote votes

use strict;
use warnings;
use DBI;

BEGIN {
    triggers->add('channel', 'peasant', '.qadd', 'qdb->add($user, $chan, $msg);');
    triggers->add('channel', 'peasant', '.quote', 'qdb->grep($chan, $msg);');
    triggers->add('channel', 'peasant', '.qvote', 'qdb->vote($user, $chan, $msg);');
    triggers->add('channel', 'peasant', '.qrand', 'qdb->qrand($chan, $msg);');
    triggers->add('channel', 'peasant', '.qtop', 'qdb->top($chan, $msg);');
}

sub add {
    my ($username, $channel, @quote) = ($_[1], $_[2], split " ", $_[3]);
    $quote[0] = '';

    if($quote[1] !~ /<(.*)>/) {
	$irc::socket->send("PRIVMSG $channel :For now this quote feature only allows <nickname> parsing\r\n");
    } else {	 
	# mysql db (will use sql module when fixed)
	my $dsn = "DBI:mysql:database=anunnaki;host=localhost";
   	my $dbh = DBI->connect($dsn, 'wired', 'lolw3rd!') or die "can't connect to mysql database anunnaki\n";
 	my $query = do { my @values = ("?") x @quote; "INSERT INTO qdb (quote) VALUES (@values)"};
#	my $sth = $dbh->prepare($query);
#        $sth->execute(@quote);
#	$sth->finish();
	$dbh->disconnect();


	# plaintext db
	open(my $qin, "<db/qdb.db");
	my @infos = <$qin>;
	for my $lines (@infos) { 
	    my @params = $lines;
	    my $num = $params[0];
	    my $nnum = $num + 1;
	    print $num;
	close($qin);
	open(my $qout, ">>db/qdb.db");
	print $qout "$nnum @quote\n";
	close($qout);
}
	$irc::socket->send("PRIVMSG $channel :Quote has been added to the database.\r\n");
    }
}


sub grep {
    my ($chan, @data) = ($_[1], split " ", $_[2]);
    my $grep = $data[1];
    $grep =~ s/\*/\\\*/;
    $grep =~ s/\?/\\\?/;
    $grep =~ s/\+/\\\+/;
    
    open(my $qout, "<db/qdb.db");
    my @quotes = <$qout>;
    my @res = grep(/$grep/, @quotes);
    close($qout);

    for my $line (@res) {
	$irc::socket->send("PRIVMSG $chan :$line\r\n");
    }    
}

sub vote {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);

    sql->conn();
    sql->close();
        

}

sub qrand {

}

sub top {

}

1;
