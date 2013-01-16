#! /usr/bin/perl -w
# This script pulls OID and Book Number from OR records in standard layout.
# First, it prints a list of OIDs, each OID followed by all of the Book Numbers
# with that OID.
# Then it prints all of the Book Numbers, followed by all OIDs with that
# Book number.
# This Allows you to find if there is a one-to-one, one-to-many, or
# many-to-many relationship between OIDs and Book Numbers.

my %BOOKNUM;
my %OID;

while(<>){
	chomp $_;
	if(/^OR.{38}?(.{25}?)(.{25}?)/){
		my $oid = $1;
		my $booknum = $2;
		$oid =~ s/\s//g;
		$booknum =~ s/\s//g;
		@{$OID{$booknum}} = grep( !/$oid/, @{$OID{$booknum}});
		push( @{$OID{$booknum}} , $oid );
		@{$BOOKNUM{$oid}} = grep( !/$booknum/, @{$BOOKNUM{$oid}});
		push( @{$BOOKNUM{$oid}} , $booknum );
	}
}

for my $oid (keys(%BOOKNUM)){
	print("OID: $oid Booknum:");
	for my $booknum ( @{$BOOKNUM{$oid}} ){
		print(" $booknum");
	}
	print "\n";
}

for my $booknum (keys(%OID)){
	print("Booknum: $booknum OID:");
	for my $oid ( @{$OID{$booknum}} ){
		print(" $oid");
	}
	print "\n";
}
