package users;

use strict;
use warnings;

our %users;

sub register {
    my ($username, $ident, $vhost, $from, @data) = ($_[1], $_[2], $_[3], $_[4], split " ", $_[5]);

    if($from =~ m/^\#(.*?)$/i) {
	$irc::socket->send("PRIVMSG $from :$username in order to register you must msg the bot with .register <yourpass>\r\n");
    }elsif($from eq "anunnaki") {
        my $password = $data[1];
        my $mask = "$username\!$ident\@$vhost";

        open my $uid, "> db/users/$username\.user";
        print $uid "loggedin:1\n",
	    "mask:$mask\n",
	    "nick:$username\n",
	    "password:$password\n",
	    "type:normal\n";

        close $uid;
        $irc::socket->send("PRIVMSG $username :Your username has been registered and saved to the database.\r\n");
    }
}

sub authed {
    my($username, $ident, $vhost) = ($_[1], $_[2], $_[3]);
    
    if(defined $users{$username}->{'loggedin'} && $users{$username}->{'loggedin'} == 1 && $users{$username}->{'mask'} eq "$username\!$ident\@$vhost") {
	return $users{$username}->{'type'};
    } else {
	return 'normal';
    }
}

sub access {
}

1;
