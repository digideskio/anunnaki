#!/usr/bin/perl
#################################################
#                                      _    _   #
#   __ _ _ __  _   _ _ __  _ __   __ _| | _(_)  #
#  / _` | '_ \| | | | '_ \| '_ \ / _` | |/ / |  #
# | (_| | | | | |_| | | | | | | | (_| |   <| |  #
#  \__,_|_| |_|\__,_|_| |_|_| |_|\__,_|_|\_\_|  #
#			         - they exist!	#
# 						#
# modular perl irc bot				#
#						#
#################################################
use strict;
use warnings;
use IO::Socket::INET;

my @source = <src/*.pm>;
my @modules = <modules/*.pm>;

print "Loading handlers...\n";

foreach my $s (@source) {
    print "$s loaded.\n";
    require $s;
}

print "Loading modules...\n";

foreach my $m (@modules) {
    print "$m loaded.\n";
    require $m;
}
 
my $irc = irc::new('irc.anonnet.org', 'anewnaki', '#anunnaki,#anonnet');
