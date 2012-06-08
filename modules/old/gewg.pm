package google;

use strict;
use warnings;
use IO::Socket::INET;

BEGIN {
    triggers->add('channel', 'peasant', '.google', 'google->search($chan, $msg);');
}

sub search {
    my ($chan, @data) = ($_[1], split " ", $_[2]);

    my $gsock = IO::Socket::INET->new(PeerAddr => 'www.google.com', PeerPort => '80', Proto => 'tcp', Type => SOCK_STREAM, Timeout => '10');
    
    $data[0] = '';
    my $x = 1;
    my $query;
    while($data[$x]) {
        $query .= $data[$x];
	$query .= "%20";
	$x++;

        print $gsock "GET /search?num=1&hl=en&lr=lang_en&q=$query&btnG=SEARCH HTTP/1.0\n";
        print $gsock "Host: www.google.com\n\n";
    
        my $get;
        my @search = split("%20", $query);
        my $term = join(" ", @search);
    
        while($get = <$gsock>) {
	    $get =~ m/<a class=1 href="(.*?)">/;
            $get =~ m!(h2 class=r><a href=\")((http\://|https\://|ftp\://)|(www.))+(([a-zA-Z0-9\.-]+\.[a-zA-Z]{2,4})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(/[a-zA-Z0-9%:/-_\?\.'~]*)?\"!;
	    my @lines = $get;
	    foreach my $line (@lines) {
		$line =~ m/<a class=1 href="(.*?)">/;
		open(my $googin, ">db/google.txt");
		print $googin "$1\n";
		close($googin);
#   	        $irc::socket->send("PRIVMSG $chan :Search Term: $term || Result :$line\r\n");
	    }
        }
    }
}

1;

