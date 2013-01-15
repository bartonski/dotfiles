#! /usr/bin/perl -w

use Getopt::Long;
use Term::ANSIColor qw(:constants colored);
$Term::ANSIColor::AUTORESET = 1;

my $fmtFile=".format";
my $result = GetOptions ( "format_file"  => \$fmtFile);  # flag
my @formats;

open( FMT, $fmtFile) or die "Cannot open format file $fmtFile: $!";
while(<FMT>){
	chomp;
	my @fmtline = split(',', $_);
	push @formats, \@fmtline;
}

while( <> ){
	my $pos = 0;
	foreach my $fmt (@formats){
		my $col = $$fmt[0] - 1;
		my $len = $$fmt[1];
		my $type="WHITE ON_BLUE";
		$type ||= $$fmt[2];
		print substr($_, $pos, $col-$pos) unless( $pos > length($_) );
		print colored(substr($_, $col, $len), 'white on_blue') unless ( $col + $len > length($_) );
		#print substr($_, $col, $len); 
		#print color 'reset';
		$pos = $col + $len;
	}
	print substr($_, $pos) unless( $pos > length($_) );
	print "\n";
}
