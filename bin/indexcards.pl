#! /usr/bin/perl

# Takes a text file or reads standard input consisting of pairs of colon delimited lines.
# The first line each pair has the format TITLE : SUBTITLE [ description 1ine1 : descripton line2 : ... ]
# Each line will be printed as a cell in a 2 column table.
#
# For example
#
# 16859   southernnh: Missing Periodical Records : research missing records
#
# "16859   southernnh" is the title, is printed very large and bold.
# "Missing Periodical Records" is the subtitle, printed large and bold.
# "research missing records" is a line of description; this is printed
# at a regular size and weight.

use warnings;
use strict;
use v5.10.0;
use File::Spec;

# bar code
# http://www.microscan.com/Barcode/idalin.asp?BARCODE=987654321&BAR_HEIGHT=1.25&CODE_TYPE=4&CHECK_CHAR=N&ROTATE=0&ST=Y&BACK_COLOUR=&FORE_COLOUR=&IMAGE_TYPE=1&DPI=59

#sub cell {
sub front {
    my $fh = shift;
    my @ticket = split ': ', shift;
    my $title = shift @ticket;
    my $subtitle = shift @ticket;
    $subtitle //= '';
    print $fh "<td>"; 
    print $fh qq|<div class="title">$title</div>|;
    print $fh qq|<div class="subtitle">$subtitle</div>|;
    print $fh join( "<br />", @ticket );
    print $fh "</td>\n"; 
}

sub back {
    my $fh = shift;
    my @ticket = split ': ', shift;
    print $fh "<td>"; 
    print $fh join( "<br />", @ticket );
    print $fh "</td>\n"; 
}

sub body {
    my $fh = shift;
    my $page_data = shift;
    say $fh '<body>';
    table( $fh, $page_data );
    say $fh "</body>\n</html>";
}

sub table {
    my $fh = shift;
    my $page_data = shift;
    say( $fh "<table>");
    foreach my $row ( @$page_data ) {
        say( $fh "<tr>");
        front(  $fh, $row->{front} ); 
        front(  $fh, $row->{back} ) if ( defined $row->{back} ); 
        say( $fh "</tr>");
    }
    say  $fh "</table>";
}

sub head {
    my $fh = shift;
    my $filename = shift;
    my $rows_per_page = shift;
    my $total_height = 900;
    my $cell_height = 600 / $rows_per_page ;
    #TODO td, th { height } should be calculated from rows per page.
    say $fh "<html>
<head>
<title>$filename</title>
<style>
table {
    border-collapse:collapse;
}
table,th, td {
    text-align:center;
    font-size: 18px;
    border: 1px solid black;
}
th, td {
    width: 375px;
    height: ${cell_height}px;
}
div.title {
    font-size: 22px;    
    font-weight: 900;
}
div.subtitle {
    font-size: 18px;    
    font-weight: 900;
}
</style>
</head>
";
}

my @raw=();
my $data_read = 0;
sub get_page_data {
    unless( $data_read ) {
        @raw = <>;
        $data_read = 1;
    }
    my $rows_per_page=shift;
    my $number_of_rows_read=0;
    my $page_data = [];

    READ_ROW: for my $row (1 .. $rows_per_page ) {
        my $current_row = {};
        if( scalar( @raw > 1 ) ) {
            $current_row->{front} = shift @raw;
            $current_row->{back}  = shift @raw;
        } elsif( scalar( @raw == 1 ) ) {
            $current_row->{front} = shift @raw;
            $current_row->{back}  = ': ';
        } else {
            last  READ_ROW;
        }
        push @$page_data, $current_row;
    }
    return (scalar @$page_data == 0) ? undef : $page_data;
}

sub main {
    # TODO: should be able to specify output file name on command line.
    my $home=$ENV{HOME};
    my $basename='flashcard';
    my $page_counter=1;
    my $output_path="/tmp";
    my $rows_per_page = 6;
    if( scalar @ARGV == 2 ) {
        $rows_per_page = shift @ARGV;
    }
   
    while( my $page_data=get_page_data( $rows_per_page ) ) {
        my $filename="${basename}." . sprintf("%03d", $page_counter) . ".html";
        my $output_file=File::Spec->join($output_path, $filename );
        my $OUT_FH;
        open( $OUT_FH, '>', $output_file) or die "Cannot open '$output_file' for output: $!";
        head( $OUT_FH, $filename, $rows_per_page );
        body( $OUT_FH, $page_data );
        close $OUT_FH;
        $page_counter++;
    }
}

main()
