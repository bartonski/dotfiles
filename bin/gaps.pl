#! /usr/bin/perl

$previous = 0;
while( $current = <> ) {
    chomp $current;
    next if( $current !~ /^\d+$/ );
    unless( $current - $previous == 1 ) {
        printf "%d-%d\n", $previous, $current-1 ;
    }
    $previous=$current ;
}
