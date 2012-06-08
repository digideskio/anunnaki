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
#            print $line;
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

sub chperms {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    
    if(!$data[1] || !$data[2]) {
	$irc::socket->send("PRIVMSG $chan :Usage: !perms <username> <type> types: god,pharoah,lord,peasant\r\n");
    } else {
        my $path = 'db/users/$data[1].user';

	if(-e $path) {
            open(my $uin, "<db/users/$data[1].user");
   	    my @infos = <$uin>;
	    close($uin);
	    my ($var, $type) = split(/\s*:\s*/, $infos[4]);
	
	    $irc::socket->send("PRIVMSG $chan :$var:$type\r\n");

            open(my $uout, ">db/users/$data[1].user");
	    foreach my $line (@infos) {
	        $line =~ s/$var\:$type/type\:$data[2]/g;
	        print $uout "$line";
	    }
	    close($uout);

	    $irc::socket->send("PRIVMSG $chan :Changed user type for $data[1] to $data[2] from $type\r\n");
	} else {
	    $irc::socket->send("PRIVMSG $chan :$data[1] does not exist in the users database.\r\n");
	}
    }   
}

1;
