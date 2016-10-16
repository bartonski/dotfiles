#! /usr/bin/perl -w

my $wchar = $ARGV[0];

my $i;

my @rule = split //, "....^....|"; # ruler characters

for($i = 0; $i < $wchar; $i++){ # note this is 0 based
	if( ($i % 10) == 9 ){
		print( (($i+1) % 100) / 10 ); # print 10s digit
	} else {
		print( $rule[$i % 10] ); # print ruler character
	}
}
print "\n";

for($i = 1; $i <= $wchar; $i++){ # note this is 1 based
	print( $i % 10 );
}
print "\n";
