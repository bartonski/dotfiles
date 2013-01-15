#! /usr/bin/perl

use warnings;
use strict;

use Getopt::Long;

use OpenOffice::OODoc;
use Text::CSV_XS;

my $outfile;
my $csvfile;

my $result = GetOptions(
    #'help'      => \usage(),
    'csvfile=s' => \$csvfile,
    'oofile=s'  => \$outfile
);

$outfile ||= 'table.odt';

sub usage {
    print "Usage: $0 --csvfile=file.csv [ --oofile file.odt ]\n" ;
    print "       $0 --help\n" ;
    print "use perldoc $0 for full documentation\n" ;
    exit;
}

my @rows;
my $csv = Text::CSV_XS->new ({ binary => 1 }) or
    die "Cannot use CSV: ".Text::CSV_XS->error_diag ();
open my $fh, "<:encoding(utf8)", "$csvfile" or die "$csvfile: $!";
while (my $row = $csv->getline ($fh)) {
    #$row->[2] =~ m/pattern/ or next; # 3rd field should match
    push @rows, $row;
}

$csv->eof or $csv->error_diag ();
close $fh;

my $nrows=scalar( @rows );
my $ncols=scalar( @{$rows[0]} ); 

# load output file
my $container = odfContainer( $outfile, create => 'text' );

my $doc = odfDocument
        (
        container => $container,
        part      => 'content'
        );

$doc->createStyle( 
    'mystyle', 
    family => 'table-cell',  
    properties => {
         'fo:background-color'  => '#cccccc',
         'fo:border'            => '0.0069in solid #000000',
         'fo:padding-bottom'    => '0in'    ,
         'fo:padding-left'      => '0.075in',
         'fo:padding-right'     => '0.075in',
         'fo:padding-top'       => '0in'    ,
         'style:vertical-align' => 'top'    ,
         'style:writing-mode'   => 'lr-tb'
    }
);

$doc->createStyle( 
    'tableheader',
    family => 'table',
    properties => {
                        -area                   => 'text',
                        'style:font-name'       => 'Arial',
                        #'style:font-name'       => 'Times',
                        'fo:font-size'          => '28pt',
                        #'fo:font-size'          => '14pt',
                        'fo:font-weight'        => 'bold'
    }
);

$doc->createStyle( 
    'mystyle2', 
    family => 'table-cell',  
    properties => {
         'fo:border-bottom'     => '0.0069in solid #000000',
         'fo:border-left'       => '0.0069in solid #000000',
         'fo:border-right'      => '0.0069in solid #000000',
         'fo:border-top'        => '0.0069in solid #000000',
         'fo:padding-bottom'    => '0in',
         'fo:padding-left'      => '0.075in',
         'fo:padding-right'     => '0.075in',
         'fo:padding-top'       => '0in',
         'style:vertical-align' => 'top',
         'style:writing-mode'   => 'lr-tb',
    }
);

# Create table in $doc
my $newtable=$doc->appendTable('newtable', $nrows, $ncols, 'table-style' => 'mystyle2' );

## Set style of first cell in $newtable to 'Table1.A1'
#$doc->cellStyle( $newtable, 0, 0, 'mystyle' );
#$doc->cellSpan($newtable, 0, 0, 2);

my $rownum = 0;

foreach my $row ( @rows ) {
    if ( $row->[0] eq 'Span' ) {
        my $cell = $doc->getTableCell($newtable, $rownum, 0);
        $doc->cellSpan($newtable, $rownum, 0, $ncols);
        my $val = $row->[1];
        if ($row->[1] =~ /\*(.*)\*/ ) {
            $val = $1;
        }
        $doc->cellValue( $newtable, $rownum, 0, $val );
        $doc->cellStyle( $newtable, $rownum, 0, 'mystyle' );
        $doc->textStyle( $cell, 'tableheader' );
    } else {
        for (my $column=0; $column < $ncols; $column++ ) {
            my $style = 'mystyle2';
            my $val = $row->[$column];
            if ($row->[$column] =~ /\*(.*)\*/ ) {
                $val = $1;
                $style = 'mystyle';
            }
            $doc->cellValue( $newtable, $rownum, $column, $val);
            $doc->cellStyle( $newtable, $rownum, $column, $style );
        }
    }
    $rownum++;
}

# Write 'doc.odt' to disk
$container->save;
$container->raw_export("styles.xml");
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

tablemaker.pl - Create Open Office Writer tables from CSV input.

=head1 SYNOPSIS

  tablemaker.pl --csvfile file.csv [ --oofile file.odt ]

=head1 DESCRIPTION

Tablemaker.pl takes a CSV file, specified using the '--csvfile' command line
option, and creates an Open Office Text formatted table from the CSV input.
The Open Office Text file will be named './table.odt' if '--ofile' is not 
specified.

All input lines in the CSV file must have the same number of fields. If the
first field on the line is "Span", a single field will be created that spans
the entire table; the second field on the line will contain the text of that
line.

If a field is surrounded by asterisks, that field will be rendered as a header
field, displaying a gray background.

=head1 EXAMPLES

=head2 Example 1

The csv file "ifdetails.csv" looks like this:

 "Span","*Interface Details*"
 "IF Created by:","Appriss"
 "Appriss Engineer:","Barton Chittenden"

Running the command 

tablemaker.pl --csvfile ifdetails.csv --oofile ifdetails.odt

Will create the file 'ifdetails.odt', which looks something like this:

 +-----------------------------------------------------------------+
 | Interface Details ::::::::::::::::::::::::::::::::::::::::::::::|
 +-------------------------------------+---------------------------+
 | IF Created by:                      | Appriss                   |
 +-------------------------------------+---------------------------+
 | Appriss Engineer:                   | Barton Chittenden         |
 +-------------------------------------+---------------------------+

=head2 Example 2

The csv file "offender.csv" looks like this:

 "*Column*","*Length*","*Agency Field Name*","*Field Description*"
 "1","2","Header","'OR'"
 "2","8","BKDATE","BOOKING_DATE"

Running the command 

tablemaker.pl --csvfile offender.csv --oofile offender.odt

Will create the file 'offender.odt', which looks something like this:

 +--------+--------+------------------------+----------------------+
 |Column::|Length::|Agency Field Name:::::::|Field Description:::::|
 +--------+--------+------------------------+----------------------+
 |1       |2       |Header                  |'OR'                  |
 +--------+--------+------------------------+----------------------+
 |2       |8       |BKDATE                  |BOOKING_DATE          |
 +--------+--------+------------------------+----------------------+

=head1 PREREQISITES

This program requires the following perl modules, available from CPAN:

 OpenOffice::OODoc
 Text::CSV_XS

=head1 AUTHOR

Barton Chittenden, E<lt>bchittenden@appriss.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Barton Chittenden

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut

