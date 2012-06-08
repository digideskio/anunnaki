package google;

use strict;
use warnings;
use LWP::UserAgent;

BEGIN {
    triggers->add('channel', 'peasant', '.google', 'google->search($chan, $msg);');
}

sub search {
    my ($chan, @data) = ($_[1], split " ", $_[2]);
    shift(@data);

    my $page = "http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=".@data;
    my $get = HTTP::Request->new('GET', $page);
    my $ua = LWP::UserAgent->new();
    $ua->agent("Mozilla/6.0");
    $ua->timeout(20);

    my $result = $ua->request($get) or $irc::socket->send("PRIVMSG $chan :Unable to fetch data.\r\n");
    

    if($result->is_success) {
        for my $line ($result->decoded_content) {
#	    $line = decode_entities($line);
#	    $line =~ m/<a href=\"(.*?)\"/g;
	    open(my $googin, ">db/google.txt");
	    print $googin "$line\n";
	    close($googin);
	    $irc::socket->send("PRIVMSG $chan :$result->decoded_content\r\n");
	}
    } else {
	$irc::socket->send("PRIVMSG $chan :$result->decoded_content\r\n");	
    }
}

1;
