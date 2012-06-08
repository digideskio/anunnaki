package google;

use strict;
use warnings;
#use Data::Dumper;
use REST::Google::Search qw/WEB/;

BEGIN {
    triggers->add('channel', 'peasant', '.google', 'google->search($chan, $msg);');
}

sub search {
    my ($chan, @data) = ($_[1], split " ", $_[2]);
    shift(@data);

    $irc::socket->send("PRIVMSG $chan :Test\r\n");
    
    REST::Google::Search->http_referer('http://dope.umad.us');

    my $query = REST::Google::Search->new( q => '@data', hl => 'en');
    $irc::socket->send("PRIVMSG $chan :Response status failure\r\n") if $query->responseStatus != 200;



#    $irc::socket->send("PRIVMSG $chan :$query\r\n"); 
   
    my $result = $query->responseData;
    $result = $query->decoded_response;
    my $cursor = $result->cursor;
    my $pages = $cursor->pages;

#    $irc::socket->send("PRIVMSG $chan :Current page index: $cursor->currentPageIndex\r\n");

    my @links = $result->results;

    foreach my $url (@links) {
	$irc::socket->send("PRIVMSG $chan :$url->titleNoFormatting\r\n");
    }
}

1;
