#! /usr/bin/perl

use Modern::Perl;
use List::Util qw( shuffle );
use YAML qw( DumpFile LoadFile );
use File::Spec;

my $CONFIG_PATH = File::Spec->join( $ENV{HOME}, '.local', 'share', 'quiz' );

mkdir $CONFIG_PATH unless ( ! -d $CONFIG_PATH );

my $quiz_file = shift @ARGV;

$quiz_file = File::Spec->join( $CONFIG_PATH, 'quiz.yml' ) unless $quiz_file;

my $quiz_set = eval { LoadFile( $quiz_file ) };

unless( $quiz_set ) {

    my $QUIZ_FP;

    open( $QUIZ_FP, '<' , $quiz_file ) or die "Cannot open quiz file: $quiz_file";

    my @QA = ();
    while ( <$QUIZ_FP> ) {
        chomp;
        my $quiz = {};
        $quiz->{question} = $_;
        die "Questions and answers out of sync:'$quiz->{question}'" unless( /^Q:/ );
        $quiz->{question} =~ s"^Q: ""g;
        $quiz->{question} =~ s": "\n"g;
        $quiz->{answer} = <$QUIZ_FP>;
        chomp $quiz->{answer};
        next if( ! defined($quiz->{answer}) || $quiz->{answer} =~ /^A: foo/ );
        $quiz->{answer} =~ s"^A: ""g;
        $quiz->{question} =~ s": "\n"g;
        $quiz->{answer} =~ s": "\n"g;
        push @QA, $quiz;
    }

    close $QUIZ_FP;

    $quiz_set = {
        quit        => 0,
        unasked     => [ shuffle @QA ],
        requiz      => [],
        correct     => [],
        badquestion => []
    };
}

sub quiz_user {
    my $qs = shift;
    my $quiz = shift @{ $qs->{unasked} } ;
    my $input;

    say "\n\n$quiz->{question}";
    print "    [Press ENTER]";
    $input = <>;
    say $quiz->{answer};
    say "    Was your answer correct? Enter [ '' => Yes | n => No | q => Quit | x => Bad Question ]";
    $input = <>;
    if ( $input =~ /^n/i ) {
        push @{ $qs->{requiz} }, $quiz;
    } elsif ( $input =~ /^q/i ) {
        unshift @{ $qs->{unasked} }, $quiz;
        $qs->{quit} = 1;
    } elsif ( $input =~ /^x/i ) {
        push @{ $qs->{badquestion} }, $quiz;
    } ;
    return $qs;
}

my $input = '';
while( not $quiz_set->{quit} ) {
    $quiz_set = quiz_user( $quiz_set );
    if ( not defined( $quiz_set->{unasked} ) ) {
        last if ( not defined( $quiz_set->{requiz} ) );
        $quiz_set->{unasked} = ( shuffle @{ $quiz_set->{requiz} } );
        $quiz_set->{requiz} = [];
    }
}

$quiz_set->{quit} = 0;

DumpFile ( $quiz_file, $quiz_set );
