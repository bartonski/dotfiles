#! /usr/bin/perl -w

sub pad($$) {
	my $str = shift;
	my $len = shift;
	$str = sprintf("%${len}s", $str);	#return $str
}

sub resize($$) {
	my $str = shift;
	my $len	= shift;
	$str = length($str) > $len ? substr($str,0, $len) : pad( $str, $len );
}

use strict;

my $target="XXXXXX";
my $replacement=resize("abracadabra", length($target));
my $string="12345678901234567890XXXXXX789012345678901234567890";
my $numstring="12345678901234567890123456789012345678901234567890";

print("$string\n");
my $idx = index($string, $target);
substr($string, $idx, length($target) ) = $replacement;
print("$string\n");
print("$numstring\n");

