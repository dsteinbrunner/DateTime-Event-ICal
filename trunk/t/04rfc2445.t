#!/bin/perl
# Copyright (c) 2003 Flavio Soibelmann Glock. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# modified from Date::Set tests
#

use strict;
use warnings;
use Test::More qw(no_plan);

use DateTime::Span;
BEGIN { use_ok('DateTime::Event::ICal') };

my ($title, $a, $a2, $b, $period, $RFC);

# DATES

my $dt19950101Z = DateTime->new( 
    year => 1995 );
my $dt19990101Z = DateTime->new( 
    year => 1999 );
my $dt19970902T090000Z = DateTime->new( 
    year => 1997, month => 9, day => 2, hour => 9,
    # time_zone => 'US-Eastern',
 );
my $dt19971224T000000Z = DateTime->new(
    year => 1997, month => 12, day => 24, 
    # time_zone => 'US-Eastern',
 );


# PERIODS

# make a period from 1995 until 1999
my $period_1995_1999 = DateTime::Span->new(
            start => $dt19950101Z, end => $dt19990101Z );


# TESTS

$title="***  Daily for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=DAILY;COUNT=10
#
#     ==> (1997 9:00 AM EDT)September 2-11
#
    $a = DateTime::Event::ICal->recur( 
            dtstart => $dt19970902T090000Z ,
            freq => 'daily', 
            count => 10 )
            ->intersection( $period_1995_1999 );
    is("".$a->{set}, 
        '1997-09-02T09:00:00,1997-09-03T09:00:00,' .
        '1997-09-04T09:00:00,1997-09-05T09:00:00,' .
        '1997-09-06T09:00:00,1997-09-07T09:00:00,' .
        '1997-09-08T09:00:00,1997-09-09T09:00:00,' .
        '1997-09-10T09:00:00,1997-09-11T09:00:00', $title);


$title="***  Daily until December 24, 1997  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=DAILY;UNTIL=19971224T000000Z
#
#     ==> (1997 9:00 AM EDT)September 2-30;October 1-25
#         (1997 9:00 AM EST)October 26-31;November 1-30;December 1-23
#
    $a = DateTime::Event::ICal->recur(
            dtstart => $dt19970902T090000Z ,
            freq => 'daily',
            until => $dt19971224T000000Z )
            ->intersection( $period_1995_1999 );
    is("".$a->{set},
        '1997-09-02T09:00:00,1997-09-03T09:00:00,' .
        '1997-09-04T09:00:00,1997-09-05T09:00:00,' .
        '1997-09-06T09:00:00,1997-09-07T09:00:00,' .
        '1997-09-08T09:00:00,1997-09-09T09:00:00,' .
        '1997-09-10T09:00:00,1997-09-11T09:00:00,' .
        '1997-09-12T09:00:00,1997-09-13T09:00:00,' .
        '1997-09-14T09:00:00,1997-09-15T09:00:00,' .
        '1997-09-16T09:00:00,1997-09-17T09:00:00,' .
        '1997-09-18T09:00:00,1997-09-19T09:00:00,' .
        '1997-09-20T09:00:00,1997-09-21T09:00:00,' .
        '1997-09-22T09:00:00,1997-09-23T09:00:00,' .
        '1997-09-24T09:00:00,1997-09-25T09:00:00,' .
        '1997-09-26T09:00:00,1997-09-27T09:00:00,' .
        '1997-09-28T09:00:00,1997-09-29T09:00:00,' .
        '1997-09-30T09:00:00,1997-10-01T09:00:00,' .
        '1997-10-02T09:00:00,1997-10-03T09:00:00,' .
        '1997-10-04T09:00:00,1997-10-05T09:00:00,' .
        '1997-10-06T09:00:00,1997-10-07T09:00:00,' .
        '1997-10-08T09:00:00,1997-10-09T09:00:00,' .
        '1997-10-10T09:00:00,1997-10-11T09:00:00,1997-10-12T09:00:00,1997-10-13T09:00:00,1997-10-14T09:00:00,1997-10-15T09:00:00,1997-10-16T09:00:00,1997-10-17T09:00:00,1997-10-18T09:00:00,1997-10-19T09:00:00,' .
        '1997-10-20T09:00:00,1997-10-21T09:00:00,1997-10-22T09:00:00,1997-10-23T09:00:00,1997-10-24T09:00:00,1997-10-25T09:00:00,' .
        '1997-10-26T09:00:00,1997-10-27T09:00:00,1997-10-28T09:00:00,1997-10-29T09:00:00,1997-10-30T09:00:00,1997-10-31T09:00:00,1997-11-01T09:00:00,1997-11-02T09:00:00,1997-11-03T09:00:00,1997-11-04T09:00:00,' .
        '1997-11-05T09:00:00,1997-11-06T09:00:00,1997-11-07T09:00:00,1997-11-08T09:00:00,1997-11-09T09:00:00,1997-11-10T09:00:00,1997-11-11T09:00:00,1997-11-12T09:00:00,1997-11-13T09:00:00,1997-11-14T09:00:00,' .
        '1997-11-15T09:00:00,1997-11-16T09:00:00,1997-11-17T09:00:00,1997-11-18T09:00:00,1997-11-19T09:00:00,1997-11-20T09:00:00,1997-11-21T09:00:00,1997-11-22T09:00:00,1997-11-23T09:00:00,1997-11-24T09:00:00,1997-11-25T09:00:00,1997-11-26T09:00:00,1997-11-27T09:00:00,1997-11-28T09:00:00,1997-11-29T09:00:00,1997-11-30T09:00:00,1997-12-01T09:00:00,1997-12-02T09:00:00,1997-12-03T09:00:00,1997-12-04T09:00:00,1997-12-05T09:00:00,1997-12-06T09:00:00,1997-12-07T09:00:00,1997-12-08T09:00:00,1997-12-09T09:00:00,1997-12-10T09:00:00,1997-12-11T09:00:00,1997-12-12T09:00:00,1997-12-13T09:00:00,1997-12-14T09:00:00,1997-12-15T09:00:00,1997-12-16T09:00:00,1997-12-17T09:00:00,1997-12-18T09:00:00,1997-12-19T09:00:00,1997-12-20T09:00:00,1997-12-21T09:00:00,' .
        '1997-12-22T09:00:00,1997-12-23T09:00:00' ,

        $title);

__END__


$title="***  Every other day - forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=DAILY;INTERVAL=2
#     ==> (1997 9:00 AM EDT)September2,4,6,8...24,26,28,30;
#          October 2,4,6...20,22,24
#         (1997 9:00 AM EST)October 26,28,30;November 1,3,5,7...25,27,29;
#          Dec 1,3,...
#
    # make a period from 1995 until 1998
    $period = Date::Set->period( time => ['19950101Z', '19980101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'DAILY', INTERVAL=>2 )
        ->occurrences( period => $period );
    is("$a", 

        '19970902T090000Z,19970904T090000Z,19970906T090000Z,19970908T090000Z,19970910T090000Z,19970912T090000Z,19970914T090000Z,19970916T090000Z,19970918T090000Z,19970920T090000Z,19970922T090000Z,19970924T090000Z,19970926T090000Z,19970928T090000Z,19970930T090000Z,' .
        '19971002T090000Z,19971004T090000Z,19971006T090000Z,19971008T090000Z,19971010T090000Z,19971012T090000Z,19971014T090000Z,19971016T090000Z,19971018T090000Z,19971020T090000Z,19971022T090000Z,19971024T090000Z,' .
        # NO EDT/EST SUPPORT HERE !
        '19971026T090000Z,19971028T090000Z,19971030T090000Z,' .
        '19971101T090000Z,19971103T090000Z,19971105T090000Z,19971107T090000Z,19971109T090000Z,19971111T090000Z,19971113T090000Z,19971115T090000Z,19971117T090000Z,19971119T090000Z,19971121T090000Z,19971123T090000Z,19971125T090000Z,19971127T090000Z,19971129T090000Z,' .
        '19971201T090000Z,19971203T090000Z,19971205T090000Z,19971207T090000Z,19971209T090000Z,19971211T090000Z,19971213T090000Z,19971215T090000Z,19971217T090000Z,19971219T090000Z,19971221T090000Z,19971223T090000Z,19971225T090000Z,19971227T090000Z,19971229T090000Z,19971231T090000Z',
        $title);

$title="***  Every 10 days, 5 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=DAILY;INTERVAL=10;COUNT=5
#
#     ==> (1997 9:00 AM EDT)September 2,12,22;October 2,12
#
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'DAILY', INTERVAL=>10, COUNT=>5 )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970912T090000Z,19970922T090000Z,' .
        '19971002T090000Z,19971012T090000Z', 
        $title);

$title="***  Everyday in January, for 3 years  ***";
#
#     DTSTART;TZID=US-Eastern:19980101T090000
#     recur_by_rule:FREQ=YEARLY;UNTIL=20000131T090000Z;
#      BYMONTH=1;BYDAY=SU,MO,TU,WE,TH,FR,SA
#     or
#     recur_by_rule:FREQ=DAILY;UNTIL=20000131T090000Z;BYMONTH=1
#
#     ==> (1998 9:00 AM EDT)January 1-31
#         (1999 9:00 AM EDT)January 1-31
#         (2000 9:00 AM EDT)January 1-31
#
    # FIRST FORM

    # make a period from 1995 until 2001
    $period = Date::Set->period( time => ['19950101Z', '20010101Z'] );
    $a = Date::Set->event->dtstart( start => '19980101T090000Z' )
        ->recur_by_rule( FREQ=>'YEARLY', UNTIL=>'20000131T090000Z',
                BYMONTH=>[1], BYDAY=> [ qw(SU MO TU WE TH FR SA) ] )
        ->occurrences( period => $period );
    is("$a", 
        '19980101T090000Z,19980102T090000Z,19980103T090000Z,19980104T090000Z,19980105T090000Z,19980106T090000Z,19980107T090000Z,19980108T090000Z,19980109T090000Z,19980110T090000Z,19980111T090000Z,19980112T090000Z,19980113T090000Z,19980114T090000Z,19980115T090000Z,19980116T090000Z,19980117T090000Z,19980118T090000Z,19980119T090000Z,19980120T090000Z,19980121T090000Z,19980122T090000Z,19980123T090000Z,19980124T090000Z,19980125T090000Z,19980126T090000Z,19980127T090000Z,19980128T090000Z,19980129T090000Z,19980130T090000Z,19980131T090000Z,' . 
        '19990101T090000Z,19990102T090000Z,19990103T090000Z,19990104T090000Z,19990105T090000Z,19990106T090000Z,19990107T090000Z,19990108T090000Z,19990109T090000Z,19990110T090000Z,19990111T090000Z,19990112T090000Z,19990113T090000Z,19990114T090000Z,19990115T090000Z,19990116T090000Z,19990117T090000Z,19990118T090000Z,19990119T090000Z,19990120T090000Z,19990121T090000Z,19990122T090000Z,19990123T090000Z,19990124T090000Z,19990125T090000Z,19990126T090000Z,19990127T090000Z,19990128T090000Z,19990129T090000Z,19990130T090000Z,19990131T090000Z,' .
        '20000101T090000Z,20000102T090000Z,20000103T090000Z,20000104T090000Z,20000105T090000Z,20000106T090000Z,20000107T090000Z,20000108T090000Z,20000109T090000Z,20000110T090000Z,20000111T090000Z,20000112T090000Z,20000113T090000Z,20000114T090000Z,20000115T090000Z,20000116T090000Z,20000117T090000Z,20000118T090000Z,20000119T090000Z,20000120T090000Z,20000121T090000Z,20000122T090000Z,20000123T090000Z,20000124T090000Z,20000125T090000Z,20000126T090000Z,20000127T090000Z,20000128T090000Z,20000129T090000Z,20000130T090000Z,20000131T090000Z',
        $title);

    # SECOND FORM


    # make a period from 1995 until 2001
    $period = Date::Set->period( time => ['19950101Z', '20010101Z'] );
    $a = Date::Set->event->dtstart( start => '19980101T090000Z' )
        ->recur_by_rule( FREQ=>'DAILY', UNTIL=>'20000131T090000Z', BYMONTH=>[1] )
        ->occurrences( period => $period );
    is("$a", 
        '19980101T090000Z,19980102T090000Z,19980103T090000Z,19980104T090000Z,19980105T090000Z,19980106T090000Z,19980107T090000Z,19980108T090000Z,19980109T090000Z,19980110T090000Z,19980111T090000Z,19980112T090000Z,19980113T090000Z,19980114T090000Z,19980115T090000Z,19980116T090000Z,19980117T090000Z,19980118T090000Z,19980119T090000Z,19980120T090000Z,19980121T090000Z,19980122T090000Z,19980123T090000Z,19980124T090000Z,19980125T090000Z,19980126T090000Z,19980127T090000Z,19980128T090000Z,19980129T090000Z,19980130T090000Z,19980131T090000Z,' . 
        '19990101T090000Z,19990102T090000Z,19990103T090000Z,19990104T090000Z,19990105T090000Z,19990106T090000Z,19990107T090000Z,19990108T090000Z,19990109T090000Z,19990110T090000Z,19990111T090000Z,19990112T090000Z,19990113T090000Z,19990114T090000Z,19990115T090000Z,19990116T090000Z,19990117T090000Z,19990118T090000Z,19990119T090000Z,19990120T090000Z,19990121T090000Z,19990122T090000Z,19990123T090000Z,19990124T090000Z,19990125T090000Z,19990126T090000Z,19990127T090000Z,19990128T090000Z,19990129T090000Z,19990130T090000Z,19990131T090000Z,' .
        '20000101T090000Z,20000102T090000Z,20000103T090000Z,20000104T090000Z,20000105T090000Z,20000106T090000Z,20000107T090000Z,20000108T090000Z,20000109T090000Z,20000110T090000Z,20000111T090000Z,20000112T090000Z,20000113T090000Z,20000114T090000Z,20000115T090000Z,20000116T090000Z,20000117T090000Z,20000118T090000Z,20000119T090000Z,20000120T090000Z,20000121T090000Z,20000122T090000Z,20000123T090000Z,20000124T090000Z,20000125T090000Z,20000126T090000Z,20000127T090000Z,20000128T090000Z,20000129T090000Z,20000130T090000Z,20000131T090000Z',
        $title);


$title="***  Weekly for 10 occurrence  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=WEEKLY;COUNT=10
#
#     ==> (1997 9:00 AM EDT)September 2,9,16,23,30;October 7,14,21
#         (1997 9:00 AM EST)October 28;November 4
#

# $Date::Set::DEBUG = 1;

    # 'FREQ=WEEKLY' MEANS THAT 'DTSTART' SPECIFIES DAY-OF-WEEK (=tuesday)

    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY', COUNT=>10 )
        ->occurrences( period => $period );
    is("$a",
        '19970902T090000Z,19970909T090000Z,19970916T090000Z,19970923T090000Z,19970930T090000Z,' .
        '19971007T090000Z,19971014T090000Z,19971021T090000Z,' .
        '19971028T090000Z,19971104T090000Z',
        $title);

# $Date::Set::DEBUG = 0;

$title="***  Weekly until December 24, 1997  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=WEEKLY;UNTIL=19971224T000000Z
#
#     ==> (1997 9:00 AM EDT)September 2,9,16,23,30;October 7,14,21
#         (1997 9:00 AM EST)October 28;November 4,11,18,25;
#                           December 2,9,16,23
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY', UNTIL=>'19971224T000000Z' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970909T090000Z,19970916T090000Z,19970923T090000Z,19970930T090000Z,' .
        '19971007T090000Z,19971014T090000Z,19971021T090000Z,' .
        '19971028T090000Z,' .
        '19971104T090000Z,19971111T090000Z,19971118T090000Z,19971125T090000Z,' .
        '19971202T090000Z,19971209T090000Z,19971216T090000Z,19971223T090000Z',
        $title);

$title="***  Every other week - forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=WEEKLY;INTERVAL=2;WKST=SU
#
#     ==> (1997 9:00 AM EDT)September 2,16,30;October 14
#         (1997 9:00 AM EST)October 28;November 11,25;December 9,23
#         (1998 9:00 AM EST)January 6,20;February
#     ...
#
    # make a period from 1995 until 1998-02
    $period = Date::Set->period( time => ['19950101Z', '19980201Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY', INTERVAL=>2, WKST=>'SU' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970916T090000Z,19970930T090000Z,' .
        '19971014T090000Z,' .
        '19971028T090000Z,' .
        '19971111T090000Z,19971125T090000Z,' .
        '19971209T090000Z,19971223T090000Z,' .
        '19980106T090000Z,19980120T090000Z',
        $title);


#### TEST 11 ##########

# $Date::Set::DEBUG = 1;

$title="***  Weekly on Tuesday and Thursday for 5 weeks  ***";
#
#    DTSTART;TZID=US-Eastern:19970902T090000
#    recur_by_rule:FREQ=WEEKLY;UNTIL=19971007T000000Z;WKST=SU;BYDAY=TU,TH
#    or
#
#    recur_by_rule:FREQ=WEEKLY;COUNT=10;WKST=SU;BYDAY=TU,TH
#
#    ==> (1997 9:00 AM EDT)September 2,4,9,11,16,18,23,25,30;October 2
#
    # FIRST

    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY',UNTIL=>'19971007T000000Z',WKST=>'SU',BYDAY=>[qw(TU TH)] )
        ->occurrences( period => $period );
    is("$a",
        '19970902T090000Z,19970904T090000Z,19970909T090000Z,19970911T090000Z,19970916T090000Z,19970918T090000Z,19970923T090000Z,19970925T090000Z,19970930T090000Z,' .
        '19971002T090000Z',
        $title);

$Date::Set::DEBUG = 0;

    # SECOND

    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY',COUNT=>10,WKST=>'SU',BYDAY=>[qw(TU TH)] )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970904T090000Z,19970909T090000Z,19970911T090000Z,19970916T090000Z,19970918T090000Z,19970923T090000Z,19970925T090000Z,19970930T090000Z,' .
        '19971002T090000Z', 
        $title);

# $Date::Set::DEBUG = 1;

$title="***  Every other week on Monday, Wednesday and Friday until December 24  ***";
#   1997, but starting on Tuesday, September 2, 1997:
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=WEEKLY;INTERVAL=2;UNTIL=19971224T000000Z;WKST=SU;
#      BYDAY=MO,WE,FR
#     ==> (1997 9:00 AM EDT)September 2,3,5,15,17,19,29;October
#     1,3,13,15,17
#         (1997 9:00 AM EST)October 27,29,31;November 10,12,14,24,26,28;
#                           December 8,10,12,22
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule(
        RRULE => 'FREQ=WEEKLY;INTERVAL=2;UNTIL=19971224T000000Z;WKST=SU;BYDAY=MO,WE,FR' )
        ->occurrences( period => $period );
    is("$a",
    '19970902T090000Z,19970903T090000Z,19970905T090000Z,19970915T090000Z,19970917T090000Z,19970919T090000Z,19970929T090000Z,' .
    '19971001T090000Z,19971003T090000Z,19971013T090000Z,19971015T090000Z,19971017T090000Z,' .
    '19971027T090000Z,19971029T090000Z,19971031T090000Z,' .
    '19971110T090000Z,19971112T090000Z,19971114T090000Z,19971124T090000Z,19971126T090000Z,19971128T090000Z,' .
    '19971208T090000Z,19971210T090000Z,19971212T090000Z,19971222T090000Z',
    $title);

$Date::Set::DEBUG = 0;

######## TEST 14

$title="***  Every other week on Tuesday and Thursday, for 8 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=WEEKLY;INTERVAL=2;COUNT=8;WKST=SU;BYDAY=TU,TH
#
#     ==> (1997 9:00 AM EDT)September 2,4,16,18,30;October 2,14,16
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=WEEKLY;INTERVAL=2;COUNT=8;WKST=SU;BYDAY=TU,TH' )
        ->occurrences( period => $period );
    is("$a", 
    '19970902T090000Z,19970904T090000Z,19970916T090000Z,19970918T090000Z,19970930T090000Z,' .
    '19971002T090000Z,19971014T090000Z,19971016T090000Z', $title);

#### TEST 15

$Date::Set::DEBUG = 0;

$title="***  Monthly on the 1st Friday for ten occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970905T090000
#     recur_by_rule:FREQ=MONTHLY;COUNT=10;BYDAY=1FR
#
#     ==> (1997 9:00 AM EDT)September 5;October 3
#         (1997 9:00 AM EST)November 7;Dec 5
#         (1998 9:00 AM EST)January 2;February 6;March 6;April 3
#         (1998 9:00 AM EDT)May 1;June 5
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970905T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;COUNT=10;BYDAY=1FR' )
        ->occurrences( period => $period );
    is("$a",
    '19970905T090000Z,' .
    '19971003T090000Z,' .
    '19971107T090000Z,' .
    '19971205T090000Z,' .
    '19980102T090000Z,' .
    '19980206T090000Z,' .
    '19980306T090000Z,' .
    '19980403T090000Z,' .
    '19980501T090000Z,' .
    '19980605T090000Z',
    $title);

$Date::Set::DEBUG = 0;

$title="***  Monthly on the 1st Friday until December 24, 1997  ***";
#
#     DTSTART;TZID=US-Eastern:19970905T090000
#     recur_by_rule:FREQ=MONTHLY;UNTIL=19971224T000000Z;BYDAY=1FR
#
#     ==> (1997 9:00 AM EDT)September 5;October 3
#         (1997 9:00 AM EST)November 7;December 5
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970905T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;UNTIL=19971224T000000Z;BYDAY=1FR' )
        ->occurrences( period => $period );
    is("$a", 
        '19970905T090000Z,' .
    '19971003T090000Z,' .
    '19971107T090000Z,' .
    '19971205T090000Z',
    $title);

# $Date::Set::DEBUG = 0;

$title="***  Every other month on the 1st and last Sunday of the month for 1  ***";
#   occurrences:
#
#     DTSTART;TZID=US-Eastern:19970907T090000
#     recur_by_rule:FREQ=MONTHLY;INTERVAL=2;COUNT=10;BYDAY=1SU,-1SU
#
#     ==> (1997 9:00 AM EDT)September 7,28
#         (1997 9:00 AM EST)November 2,30
#
#         (1998 9:00 AM EST)January 4,25;March 1,29
#         (1998 9:00 AM EDT)May 3,31
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970907T090000Z' )
        ->recur_by_rule( RRULE => 'FREQ=MONTHLY;INTERVAL=2;COUNT=10;BYDAY=1SU,-1SU' )
        ->occurrences( period => $period );
    is("$a", 
    '19970907T090000Z,19970928T090000Z,' .
    '19971102T090000Z,19971130T090000Z,' .
    '19980104T090000Z,19980125T090000Z,' .
    '19980301T090000Z,19980329T090000Z,' .
    '19980503T090000Z,19980531T090000Z' ,
    $title);


$title="***  Monthly on the second to last Monday of the month for 6 months  ***";
#
#     DTSTART;TZID=US-Eastern:19970922T090000
#     recur_by_rule:FREQ=MONTHLY;COUNT=6;BYDAY=-2MO
#
#     ==> (1997 9:00 AM EDT)September 22;October 20
#         (1997 9:00 AM EST)November 17;December 22
#         (1998 9:00 AM EST)January 19;February 16
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970922T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;COUNT=6;BYDAY=-2MO' )
        ->occurrences( period => $period );
    is("$a", 
        '19970922T090000Z,19971020T090000Z,19971117T090000Z,19971222T090000Z,' .
    '19980119T090000Z,19980216T090000Z',
    $title);

# $Date::Set::DEBUG = 1;

$title="***  Monthly on the third to the last day of the month, forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970928T090000
#     recur_by_rule:FREQ=MONTHLY;BYMONTHDAY=-3
#
#     ==> (1997 9:00 AM EDT)September 28
#         (1997 9:00 AM EST)October 29;November 28;December 29
#         (1998 9:00 AM EST)January 29;February 26
#     ...
#
    # make a period from 1995 until 1998-03
    $period = Date::Set->period( time => ['19950101Z', '19980301Z'] );
    $a = Date::Set->event->dtstart( start => '19970928T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;BYMONTHDAY=-3' )
        ->occurrences( period => $period );
    is("$a", 
        '19970928T090000Z,' .
    '19971029T090000Z,19971128T090000Z,19971229T090000Z,' .
    '19980129T090000Z,19980226T090000Z',
    $title);

$Date::Set::DEBUG = 0;

$title="***  Monthly on the 2nd and 15th of the month for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=MONTHLY;COUNT=10;BYMONTHDAY=2,15
#
#     ==> (1997 9:00 AM EDT)September 2,15;October 2,15
#         (1997 9:00 AM EST)November 2,15;December 2,15
#         (1998 9:00 AM EST)January 2,15
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;COUNT=10;BYMONTHDAY=2,15' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970915T090000Z,' .
    '19971002T090000Z,19971015T090000Z,' .
    '19971102T090000Z,19971115T090000Z,' .
    '19971202T090000Z,19971215T090000Z,' .
    '19980102T090000Z,19980115T090000Z',
    $title);

$title="***  Monthly on the first and last day of the month for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970930T090000
#     recur_by_rule:FREQ=MONTHLY;COUNT=10;BYMONTHDAY=1,-1
#
#     ==> (1997 9:00 AM EDT)September 30;October 1
#         (1997 9:00 AM EST)October 31;November 1,30;December 1,31
#         (1998 9:00 AM EST)January 1,31;February 1
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970930T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;COUNT=10;BYMONTHDAY=1,-1' )
        ->occurrences( period => $period );
    is("$a", 
        '19970930T090000Z,19971001T090000Z,' .
    '19971031T090000Z,19971101T090000Z,19971130T090000Z,' .
    '19971201T090000Z,19971231T090000Z,' .
    '19980101T090000Z,19980131T090000Z,' .
    '19980201T090000Z',
    $title);


$title="***  Every 18 months on the 10th thru 15th of the month for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970910T090000
#     recur_by_rule:FREQ=MONTHLY;INTERVAL=18;COUNT=10;BYMONTHDAY=10,11,12,13,14,15
#
#     ==> (1997 9:00 AM EDT)September 10,11,12,13,14,15
#         (1999 9:00 AM EST)March 10,11,12,13
#
    # make a period from 1997 until 2000
    $period = Date::Set->period( time => ['19970101Z', '20000101Z'] );
    $a = Date::Set->event->dtstart( start => '19970910T090000Z' );
    $a = $a->recur_by_rule( FREQ=>'MONTHLY', INTERVAL=>18, COUNT=>10, BYMONTHDAY=>[10,11,12,13,14,15] );
    $a = $a->occurrences( period => $period );
    is("$a", 
        '19970910T090000Z,19970911T090000Z,19970912T090000Z,19970913T090000Z,19970914T090000Z,19970915T090000Z,' .
        '19990310T090000Z,19990311T090000Z,19990312T090000Z,19990313T090000Z'
        , $title);



$title="***  Every Tuesday, every other month  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=MONTHLY;INTERVAL=2;BYDAY=TU
#
#     ==> (1997 9:00 AM EDT)September 2,9,16,23,30
#         (1997 9:00 AM EST)November 4,11,18,25
#         (1998 9:00 AM EST)January 6,13,20,27;March 3,10,17,24,31
#           ...
    # make a period from 1997 until 1999
    $period = Date::Set->period( time => ['19970101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( FREQ=>'MONTHLY', INTERVAL=>2, BYDAY=>[ qw(TU) ] )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970909T090000Z,19970916T090000Z,19970923T090000Z,19970930T090000Z,' .
        '19971104T090000Z,19971111T090000Z,19971118T090000Z,19971125T090000Z,' .
        '19980106T090000Z,19980113T090000Z,19980120T090000Z,19980127T090000Z,' .
        '19980303T090000Z,19980310T090000Z,19980317T090000Z,19980324T090000Z,19980331T090000Z,' .
        '19980505T090000Z,19980512T090000Z,19980519T090000Z,19980526T090000Z,19980707T090000Z,19980714T090000Z,19980721T090000Z,19980728T090000Z,19980901T090000Z,19980908T090000Z,19980915T090000Z,19980922T090000Z,19980929T090000Z,19981103T090000Z,19981110T090000Z,19981117T090000Z,19981124T090000Z'
        , $title);



$title="***  Yearly in June and July for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970610T090000
#     recur_by_rule:FREQ=YEARLY;COUNT=10;BYMONTH=6,7
#     ==> (1997 9:00 AM EDT)June 10;July 10
#         (1998 9:00 AM EDT)June 10;July 10
#         (1999 9:00 AM EDT)June 10;July 10
#         (2000 9:00 AM EDT)June 10;July 10
#         (2001 9:00 AM EDT)June 10;July 10
#     Note: Since none of the BYDAY, BYMONTHDAY or BYYEARDAY components
#     are specified, the day is gotten from DTSTART
#
    # make a period from 1995 until 2005
    $period = Date::Set->period( time => ['19950101Z', '20050101Z'] );
    $a = Date::Set->event->dtstart( start => '19970610T090000Z' )
        ->recur_by_rule( FREQ=>'YEARLY', COUNT=>10, BYMONTH=>[6,7] )
        ->occurrences( period => $period );
    is("$a", 
        '19970610T090000Z,19970710T090000Z,' .
        '19980610T090000Z,19980710T090000Z,' .
        '19990610T090000Z,19990710T090000Z,' .
        '20000610T090000Z,20000710T090000Z,' .
        '20010610T090000Z,20010710T090000Z', $title);

###### TEST 25

$title="***  Every other year on January, February, and March for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970310T090000
#     recur_by_rule:FREQ=YEARLY;INTERVAL=2;COUNT=10;BYMONTH=1,2,3
#
#     ==> (1997 9:00 AM EST)March 10
#         (1999 9:00 AM EST)January 10;February 10;March 10
#         (2001 9:00 AM EST)January 10;February 10;March 10
#         (2003 9:00 AM EST)January 10;February 10;March 10
#
    # make a period from 1995 until 2004
    $period = Date::Set->period( time => ['19950101Z', '20040101Z'] );
    $a = Date::Set->event->dtstart( start => '19970310T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=YEARLY;INTERVAL=2;COUNT=10;BYMONTH=1,2,3' )
        ->occurrences( period => $period );
    is("$a", 
        '19970310T090000Z,' .
        '19990110T090000Z,19990210T090000Z,19990310T090000Z,' .
        '20010110T090000Z,20010210T090000Z,20010310T090000Z,' .
        '20030110T090000Z,20030210T090000Z,20030310T090000Z', $title);

$title="***  Every 3rd year on the 1st, 100th and 200th day for 10 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970101T090000
#     recur_by_rule:FREQ=YEARLY;INTERVAL=3;COUNT=10;BYYEARDAY=1,100,200
#
#     ==> (1997 9:00 AM EST)January 1
#         (1997 9:00 AM EDT)April 10;July 19
#         (2000 9:00 AM EST)January 1
#         (2000 9:00 AM EDT)April 9;July 18
#         (2003 9:00 AM EST)January 1
#         (2003 9:00 AM EDT)April 10;July 19
#         (2006 9:00 AM EST)January 1
#
    # make a period from 1995 until 2007
    $period = Date::Set->period( time => ['19950101Z', '20070101Z'] );
    $a = Date::Set->event->dtstart( start => '19970101T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=YEARLY;INTERVAL=3;COUNT=10;BYYEARDAY=1,100,200' )
        ->occurrences( period => $period );
    is("$a", 
        '19970101T090000Z,' .
    '19970410T090000Z,19970719T090000Z,' .
    '20000101T090000Z,' .
    '20000409T090000Z,20000718T090000Z,' .
    '20030101T090000Z,20030410T090000Z,20030719T090000Z,' .
    '20060101T090000Z',
    $title);

########### TEST 27

$title="***  Every 20th Monday of the year, forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970519T090000
#     recur_by_rule:FREQ=YEARLY;BYDAY=20MO
#
#     ==> (1997 9:00 AM EDT)May 19
#         (1998 9:00 AM EDT)May 18
#         (1999 9:00 AM EDT)May 17
#     ...
#
    # make a period from 1995 until 2000
    $period = Date::Set->period( time => ['19950101Z', '20000101Z'] );
    $a = Date::Set->event->dtstart( start => '19970519T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=YEARLY;BYDAY=20MO' )
        ->occurrences( period => $period );
    is("$a", 
        '19970519T090000Z,19980518T090000Z,19990517T090000Z', $title);

$title="***  Monday of week number 20 (where the default start of the week i  ***";
#   Monday), forever:
#
#     DTSTART;TZID=US-Eastern:19970512T090000
#     recur_by_rule:FREQ=YEARLY;BYWEEKNO=20;BYDAY=MO
#
#     ==> (1997 9:00 AM EDT)May 12
#         (1998 9:00 AM EDT)May 11
#         (1999 9:00 AM EDT)May 17
#     ...
#
    # make a period from 1995 until 2000
    $period = Date::Set->period( time => ['19950101Z', '20000101Z'] );
    $a = Date::Set->event->dtstart( start => '19970512T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=YEARLY;BYWEEKNO=20;BYDAY=MO' )
        ->occurrences( period => $period );
    is("$a", 
        '19970512T090000Z,19980511T090000Z,19990517T090000Z', $title);

$title="***  Every Thursday in March, forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970313T090000
#     recur_by_rule:FREQ=YEARLY;BYMONTH=3;BYDAY=TH
#
#     ==> (1997 9:00 AM EST)March 13,20,27
#         (1998 9:00 AM EST)March 5,12,19,26
#         (1999 9:00 AM EST)March 4,11,18,25
#     ...
#
    # make a period from 1995 until 2000
    $period = Date::Set->period( time => ['19950101Z', '20000101Z'] );
    $a = Date::Set->event->dtstart( start => '19970313T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=YEARLY;BYMONTH=3;BYDAY=TH' )
        ->occurrences( period => $period );
    is("$a", 
        '19970313T090000Z,19970320T090000Z,19970327T090000Z,' .
    '19980305T090000Z,19980312T090000Z,19980319T090000Z,19980326T090000Z,' .
    '19990304T090000Z,19990311T090000Z,19990318T090000Z,19990325T090000Z',
    $title);

$title="***  Every Thursday, but only during June, July, and August, forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970605T090000
#     recur_by_rule:FREQ=YEARLY;BYDAY=TH;BYMONTH=6,7,8
#
#     ==> (1997 9:00 AM EDT)June 5,12,19,26;July 3,10,17,24,31;
#                       August 7,14,21,28
#         (1998 9:00 AM EDT)June 4,11,18,25;July 2,9,16,23,30;
#                       August 6,13,20,27
#         (1999 9:00 AM EDT)June 3,10,17,24;July 1,8,15,22,29;
#                       August 5,12,19,26
#     ...
#
    # make a period from 1995 until 2000
    $period = Date::Set->period( time => ['19950101Z', '20000101Z'] );
    $a = Date::Set->event->dtstart( start => '19970605T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=YEARLY;BYDAY=TH;BYMONTH=6,7,8' )
        ->occurrences( period => $period );
    is("$a",
        '19970605T090000Z,19970612T090000Z,19970619T090000Z,19970626T090000Z,' .
    '19970703T090000Z,19970710T090000Z,19970717T090000Z,19970724T090000Z,19970731T090000Z,' .
    '19970807T090000Z,19970814T090000Z,19970821T090000Z,19970828T090000Z,' .

    '19980604T090000Z,19980611T090000Z,19980618T090000Z,19980625T090000Z,' .
    '19980702T090000Z,19980709T090000Z,19980716T090000Z,19980723T090000Z,19980730T090000Z,' .
    '19980806T090000Z,19980813T090000Z,19980820T090000Z,19980827T090000Z,' .

    '19990603T090000Z,19990610T090000Z,19990617T090000Z,19990624T090000Z,' .
    '19990701T090000Z,19990708T090000Z,19990715T090000Z,19990722T090000Z,19990729T090000Z,' .
    '19990805T090000Z,19990812T090000Z,19990819T090000Z,19990826T090000Z',
    $title);

$title="***  Every Friday the 13th, forever  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     EXDATE;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=MONTHLY;BYDAY=FR;BYMONTHDAY=13
#
#     ==> (1998 9:00 AM EST)February 13;March 13;November 13
#         (1999 9:00 AM EDT)August 13
#         (2000 9:00 AM EDT)October 13
#     ...
#
    # make a period from 1995 until 2001
    $period = Date::Set->period( time => ['19950101Z', '20010101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;BYDAY=FR;BYMONTHDAY=13' )
    ->exclude_by_date( list => [ '19970902T090000Z' ] )
        ->occurrences( period => $period );
    is("$a", 
        '19980213T090000Z,19980313T090000Z,19981113T090000Z,' .
    '19990813T090000Z,20001013T090000Z', $title);

$title="***  The first Saturday that follows the first Sunday of the month  ***";
#    forever:
#
#     DTSTART;TZID=US-Eastern:19970913T090000
#     recur_by_rule:FREQ=MONTHLY;BYDAY=SA;BYMONTHDAY=7,8,9,10,11,12,13
#
#     ==> (1997 9:00 AM EDT)September 13;October 11
#         (1997 9:00 AM EST)November 8;December 13
#         (1998 9:00 AM EST)January 10;February 7;March 7
#         (1998 9:00 AM EDT)April 11;May 9;June 13...
#     ...
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970913T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MONTHLY;BYDAY=SA;BYMONTHDAY=7,8,9,10,11,12,13' )
        ->occurrences( period => $period );
    is("$a", 
    '19970913T090000Z,19971011T090000Z,' .
    '19971108T090000Z,19971213T090000Z,' .
    '19980110T090000Z,19980207T090000Z,19980307T090000Z,' .
    '19980411T090000Z,19980509T090000Z,19980613T090000Z,' .
    '19980711T090000Z,19980808T090000Z,19980912T090000Z,' .
    '19981010T090000Z,19981107T090000Z,19981212T090000Z',
    $title);

$title="***  Every four years, the first Tuesday after a Monday in November  ***";
#   forever (U.S. Presidential Election day):
#
#     DTSTART;TZID=US-Eastern:19961105T090000
#     recur_by_rule:FREQ=YEARLY;INTERVAL=4;BYMONTH=11;BYDAY=TU;BYMONTHDAY=2,3,4,
#      5,6,7,8
#
#     ==> (1996 9:00 AM EST)November 5
#         (2000 9:00 AM EST)November 7
#         (2004 9:00 AM EST)November 2
#     ...
#
    # make a period from 1995 until 2005
    $period = Date::Set->period( time => ['19950101Z', '20050101Z'] );
    $a = Date::Set->event->dtstart( start => '19961105T090000Z' )
        ->recur_by_rule( RRULE=>
       'FREQ=YEARLY;INTERVAL=4;BYMONTH=11;BYDAY=TU;BYMONTHDAY=2,3,4,5,6,7,8' )
        ->occurrences( period => $period );
    is("$a", 
        '19961105T090000Z,20001107T090000Z,20041102T090000Z',
    $title);


$title="***  The 3rd instance into the month of one of Tuesday, Wednesday or Thursday, for the next 3 months:  ***";
#
#     DTSTART;TZID=US-Eastern:19970904T090000
#     recur_by_rule:FREQ=MONTHLY;COUNT=3;BYDAY=TU,WE,TH;BYSETPOS=3
#
#     ==> (1997 9:00 AM EDT)September 4;October 7
#         (1997 9:00 AM EST)November 6
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970904T090000Z' )
        ->recur_by_rule( FREQ=>'MONTHLY', COUNT=>3, BYDAY=>[ qw(TU WE TH) ], BYSETPOS=>[3] )
        ->occurrences( period => $period );
    is("$a", 
        '19970904T090000Z,19971007T090000Z,19971106T090000Z', $title);

$title="***  The 2nd to last weekday of the month:  ***";
#
#     DTSTART;TZID=US-Eastern:19970929T090000
#     recur_by_rule:FREQ=MONTHLY;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=-2
#
#     ==> (1997 9:00 AM EDT)September 29
#         (1997 9:00 AM EST)October 30;November 27;December 30
#         (1998 9:00 AM EST)January 29;February 26;March 30
#     ...
#
    # make a period from 1995 until 199804-
    $period = Date::Set->period( time => ['19950101Z', '19980401Z'] );
    $a = Date::Set->event->dtstart( start => '19970929T090000Z' )
        ->recur_by_rule( FREQ=>'MONTHLY', BYDAY=>[ qw(MO TU WE TH FR) ], BYSETPOS=>[-2] )
        ->occurrences( period => $period );
    is("$a", 
        '19970929T090000Z,19971030T090000Z,19971127T090000Z,19971230T090000Z,19980129T090000Z,19980226T090000Z,19980330T090000Z', $title);


$title="***  Every 3 hours from 9:00 AM to 5:00 PM on a specific day  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=HOURLY;INTERVAL=3;UNTIL=19970902T170000Z
#
#     ==> (September 2, 1997 EDT)09:00,12:00,15:00
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=HOURLY;INTERVAL=3;UNTIL=19970902T170000Z' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970902T120000Z,19970902T150000Z', $title);

$title="***  Every 15 minutes for 6 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=MINUTELY;INTERVAL=15;COUNT=6
#
#     ==> (September 2, 1997 EDT)09:00,09:15,09:30,09:45,10:00,10:15
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19970903Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MINUTELY;INTERVAL=15;COUNT=6' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970902T091500Z,19970902T093000Z,19970902T094500Z,19970902T100000Z,19970902T101500Z',
    $title);

# $Date::Set::DEBUG = 1;

$title="***  Every hour and a half for 4 occurrences  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=MINUTELY;INTERVAL=90;COUNT=4
#
#     ==> (September 2, 1997 EDT)09:00,10:30;12:00;13:30
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19970903Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=MINUTELY;INTERVAL=90;COUNT=4' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970902T103000Z,19970902T120000Z,19970902T133000Z', $title);


########## TEST 39

$title="***  Every 20 minutes from 9:00 AM to 4:40 PM every day  ***";
#
#     DTSTART;TZID=US-Eastern:19970902T090000
#     recur_by_rule:FREQ=DAILY;BYHOUR=9,10,11,12,13,14,15,16;BYMINUTE=0,20,40
#     or
#     recur_by_rule:FREQ=MINUTELY;INTERVAL=20;BYHOUR=9,10,11,12,13,14,15,16
#
#     ==> (September 2, 1997 EDT)9:00,9:20,9:40,10:00,10:20,
#                                ... 16:00,16:20,16:40
#         (September 3, 1997 EDT)9:00,9:20,9:40,10:00,10:20,
#                               ...16:00,16:20,16:40
#     ...
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19970904Z'] );
    $a = Date::Set->event->dtstart( start => '19970902T090000Z' )
        ->recur_by_rule( RRULE=>'FREQ=DAILY;BYHOUR=9,10,11,12,13,14,15,16;BYMINUTE=0,20,40' )
        ->occurrences( period => $period );
    is("$a", 
        '19970902T090000Z,19970902T092000Z,19970902T094000Z,19970902T100000Z,19970902T102000Z,' .
    '19970902T104000Z,19970902T110000Z,19970902T112000Z,19970902T114000Z,19970902T120000Z,' .
    '19970902T122000Z,19970902T124000Z,19970902T130000Z,19970902T132000Z,19970902T134000Z,' .
    '19970902T140000Z,19970902T142000Z,19970902T144000Z,19970902T150000Z,19970902T152000Z,' .
    '19970902T154000Z,19970902T160000Z,19970902T162000Z,19970902T164000Z,' .

    '19970903T090000Z,19970903T092000Z,19970903T094000Z,19970903T100000Z,19970903T102000Z,' .
    '19970903T104000Z,19970903T110000Z,19970903T112000Z,19970903T114000Z,19970903T120000Z,' .
    '19970903T122000Z,19970903T124000Z,19970903T130000Z,19970903T132000Z,19970903T134000Z,' .
    '19970903T140000Z,19970903T142000Z,19970903T144000Z,19970903T150000Z,19970903T152000Z,' .
    '19970903T154000Z,19970903T160000Z,19970903T162000Z,19970903T164000Z',
    $title);


$title="***  An example where the days generated makes a difference because of WKST  ***";
#
#     DTSTART;TZID=US-Eastern:19970805T090000
#     recur_by_rule:FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=TU,SU;WKST=MO
#
#     ==> (1997 EDT)Aug 5,10,19,24
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970805T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY', INTERVAL=>2, COUNT=>4, BYDAY=>[ qw(TU SU) ], WKST=>'MO' )
        ->occurrences( period => $period );
    is("$a", 
        '19970805T090000Z,19970810T090000Z,19970819T090000Z,19970824T090000Z', $title);



$title="***  changing only WKST from MO to SU, yields different results...  ***";
#
#     DTSTART;TZID=US-Eastern:19970805T090000
#     recur_by_rule:FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=TU,SU;WKST=SU
#     ==> (1997 EDT)August 5,17,19,31
#
    # make a period from 1995 until 1999
    $period = Date::Set->period( time => ['19950101Z', '19990101Z'] );
    $a = Date::Set->event->dtstart( start => '19970805T090000Z' )
        ->recur_by_rule( FREQ=>'WEEKLY', INTERVAL=>2, COUNT=>4, BYDAY=>[ qw(TU SU) ], WKST=>'SU' )
        ->occurrences( period => $period );
    is("$a", 
        '19970805T090000Z,19970817T090000Z,19970819T090000Z,19970831T090000Z', $title);

    # another test using this result:
    is( "" . $a->exclude_by_date( list => ['19970817T090000Z', '19970831T090000Z'] ) ,
        '19970805T090000Z,19970819T090000Z', "***  EXDATE removing 2 days  ***" );

    # yet another test using this result:
    is( "" . $a->recur_by_date( list => ['19970817Z', '19970831Z'] ) ,
        '19970805T090000Z,19970817Z,19970817T090000Z,19970819T090000Z,19970831Z,19970831T090000Z', "***  RDATE adding 2 days  ***" );

# $Set::Infinite::PRETTY_PRINT = 1;
# $Set::Infinite::TRACE = 1;

$a = Date::Set->event(
    dtstart => '19700329T020000Z',
    rule => 'FREQ=MONTHLY;BYMONTH=3;BYDAY=-3SU',
    start=>'20030101T000000Z', end=>'20050101T000000Z' );
is ( "". $a ,
  '20030316T020000Z,20040314T020000Z',
  'BYDAY works well with FREQ=MONTH' );

$a = Date::Set->event(
    dtstart => '19700329T020000Z',
    rule => 'FREQ=YEARLY;BYMONTH=3;BYDAY=-3SU',
    start=> '20030101T000000Z', end=>'20050101T000000Z' );
is ( "". $a ,
  '20030316T020000Z,20040314T020000Z',
  'BYDAY works well with FREQ=YEARLY;BYMONTH' );


1;