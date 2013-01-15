#! /usr/bin/perl -w
#  This script will modify the following files, making them ready to be
#  installed on the gateway:
#
#  getdata.rex
#  getfiles.rex
#  plist.ini
#  autoresync.rex

use strict;

# Modify getdata.rex
if( !defined($ARGV[0]) || !(defined($ARGV[0]) && $ARGV[0] =~ /nogetdata/)){
	if(-f "getdata.rex"){
		my $md5sum = `md5sum getdata.rex`;
		if ($md5sum =~ /a490135447cab1bd1bb7608dbef131d9|824be790f6067faa5d33b900593aa1f6/ ){
			rename( "getdata.rex", "getdata.current.rex");
			link("../template/getdata.rex", "./getdata.rex");
		} elsif ($md5sum =~ /eeca2faa93ee0f3663ead963ab332652/){
			rename( "getdata.rex", "getdata.current.rex");
			link("../template/getdataz.rex", "./getdata.rex");
		} elsif ($md5sum =~ /7553286079c132e5060d650cdd457a75/){
			rename( "getdata.rex", "getdata.current.rex");
			link("../template/getdatag.rex", "./getdata.rex");
		} elsif ($md5sum =~ /a928460fe1c93fc54eb6b0173aa9cd97/){
			rename( "getdata.rex", "getdata.current.rex");
			link("../template/getdataj.rex", "./getdata.rex");
		} else {
			print "getdata.rex is not an exact match with our template, here are the diffs:";
			system "diff -b ./getdata.rex ../template/getdata.old.rex";
			print "To fix this, back up the old getdata.rex to getdata.current.rex,\n";
			print "edit getdata.rex\n";
			die "please fix this and re-run using the --nogetdata option";
		}
	} else {
		die "getdata.rex does not exist!";
	}
}

# Modify getfiles.rex

if(-f "getfiles.rex"){
	rename( "./getfiles.rex", "./getfiles.current.rex");
	link("../template/getfiles.rex","./getfiles.rex");
} else {
	die "getfiles.rex does not exist!"
}

# Modify plist.ini

my $sender_id;

if(-f "plist.ini") {
	rename("plist.ini", "plist.current.ini");
	open( PLIST_IN, "plist.current.ini") or die "can't open plist.current.ini for reading";
	open( PLIST_OUT, ">plist.ini") or die "can't open plist.ini for writing";
	while(<PLIST_IN>){
		unless(/^watchdog/ || /^#/){
			my @plist_line = split(/,/);
			$sender_id = $plist_line[0];
			$plist_line[0] = "#resync_$plist_line[0]";
			$plist_line[2] = " autoresync.rex";
			$plist_line[3] = " resync";
			print PLIST_OUT "$_";
			print PLIST_OUT join(",", @plist_line);
		} else {
			print PLIST_OUT "$_";
		}
	}
	close(PLIST_IN);
	close(PLIST_OUT);
} else {
	die "plist.ini does not exist!";
}

# Modify autoresync.rex
open( AUTORESYNC_IN,  "../template/autoresync.rex") or die "cannot open ../template/autoresync.rex for reading.";
open( AUTORESYNC_OUT, ">./autoresync.rex") or die "cannot open ./autoresync.rex for writing";

while( <AUTORESYNC_IN> ){
	s/SENDER_ID/$sender_id/;
	print AUTORESYNC_OUT $_;
}
