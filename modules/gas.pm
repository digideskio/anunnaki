package gas;

use strict;
use warnings;
use Gas::Prices;

BEGIN {
    triggers->add('channel', 'peasant', '.gp', 'gas->prices($chan, $msg);');
}

sub prices {
    my ($chan, @data) = ($_[1], split " ", $_[2]);
#    my $gp = new GAS::Prices($data[1]);
    $irc::socket->send("PRIVMSG $chan :$data[1]\r\n");
    my @gas_stations = @{$gp->get_stations};

    foreach(@gas_stations) {
	$irc::socket->send("PRIVMSG $chan :Station name: $_->{station_name}\r\n");
	$irc::socket->send("PRIVMSG $chan :Sation address: $_->{station_address}\r\n");
	$irc::socket->send("PRIVMSG $chan :Unleaded price: $_->{unleaded_price}\r\n");
	$irc::socket->send("PRIVMSG $chan :Plus price: $_->{plus_price}\r\n");
	$irc::socket->send("PRIVMSG $chan :Premium price: $_->{premium_price}\r\n");
	$irc::socket->send("PRIVMSG $chan :Diesel price: $_->{diesel_price}\r\n");
    }

    my $cheapest = $gp->get_cheapest_station("unleaded");
    $irc::socket->send("PRIVMSG $chan :The cheapest unleaded grade gas near $data[1] is $cheapest->{station_name} at $cheapest->{station_address} for $cheapest->{unleaded_price}\r\n");
}

1;
