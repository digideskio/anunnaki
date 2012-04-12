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

my @source = <src/*.pm>;
my @modules = <modules/*.pm>;

print "anunnaki irc bot version 1.0 \@author wired";

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

 
my $irc = irc::new('irc.umad.us', 'anunnaki', '#thefirm');
