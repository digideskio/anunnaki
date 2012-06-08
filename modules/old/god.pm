package god;

BEGIN {
    triggers->add('channel', 'god', '.perms', 'god->chperm($user, $chan, $msg);');
}

sub chperm {
    my ($user, $chan, @data) = ($_[1], $_[2], split " ", $_[3]);
    my $check = $data[1];
    my $path = "db/users/".$check.".user";

    if(!$check) {
	$irc::socket->send("PRIVMSG $chan: Usage: .perms user <god|pharoah|lord|peasant>\r\n");
    } else {
        if(-e $path) {
 	    open(my $inuser, "<db/users/$check.user");
	    open(my $outuser, ">>db/users/$check.user");

	    print "mask:$mask
	    print "type:$data[2]";
}

1;
