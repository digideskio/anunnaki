package users;

use strict;
use warnings;
use Digest::MD5;

our %users;
users->info();

sub info {
    my @udata = <db/users/*.user>;
      
    for my $file (sort @udata) {
	my $user = $file;
#        $user =~ s/db/users\//;
        $user =~ s/\.user//;
	$user =~ s/users\//users\//;
	$user =~ s/db\///;
	$user =~ s/users\///;

	open my $uid, "< $file";
	my @tmpdat = <$uid>;
	close $uid;

	for my $line (sort @tmpdat) {
            next if $line =~ m/^#(.*?)$/i;
            print $line;
            my ($subject, $value) = split(':', $line);
            chomp($value);
            $users{$user}->{$subject} = $value;
        }
    }
}

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
	    "type:peasant\n";

        close $uid;
        $irc::socket->send("PRIVMSG $username :Your username has been registered and saved to the database.\r\n");
    }
    users->info();
}

sub login {
    my ($user, $ident, $vhost, $from, @data) = ($_[1], $_[2], $_[3], $_[4], split " ", $_[5]);

    if($from =~ m/^\#(.*?)$/i) {
	$irc::socket->send("PRIVMSG $from :$user please login with \/msg anunnaki !login <yourpass>\r\n");
    }elsif($from eq "anunnaki") {
#	my $encrypted = Digest::MD5::md5_hex(crypt($data[1], '!umad!));
#	if(!defined $users{$user}->{'password'}) {
#	    $irc::socket->send("PRIVMSG $user :You are not registred with this bot, to register .register <yourpass>\r\n");	
#	    return 0;
#	}
    }
}


sub authed {
    my($user, $ident, $vhost) = ($_[1], $_[2], $_[3]);

    if(defined $users{$user}->{'loggedin'} && $users{$user}->{'loggedin'} == 1 && $users{$user}->{'mask'} eq "$user\!$ident\@$vhost") {
	return $users{$user}->{'type'};
    } else {
	return 'peasant';
    }
}

1;
