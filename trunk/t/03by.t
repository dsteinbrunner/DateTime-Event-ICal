use strict;

use Test::More tests => 3;

use DateTime;
use DateTime::Event::ICal;

{
    my $dt1 = new DateTime( year => 2003, month => 4, day => 28,
                           hour => 12, minute => 10, second => 45,
                           time_zone => 'UTC' );

    my ( $set, @dt, $r );

    # DAILY BYMONTH
    $set = DateTime::Event::ICal->recur( 
       freq =>     'daily',
       dtstart =>  $dt1,
       bymonth =>  [ 2, 12 ],
       interval => 10  );

    @dt = $set->as_list( start => $dt1,
                         end => $dt1->clone->add( years => 1 ) );
    $r = join(' ', map { $_->datetime } @dt);
    is( $r,
        '2003-12-04T12:10:45 2003-12-14T12:10:45 2003-12-24T12:10:45 '.
        '2004-02-02T12:10:45 2004-02-12T12:10:45 2004-02-22T12:10:45',
        "daily, dtstart, interval, bymonth" );

    # YEARLY BYMONTH BYMONTHDAY
    $set = DateTime::Event::ICal->recur( 
       freq =>       'yearly',
       dtstart =>    $dt1,
       bymonth =>    [ 2, 12 ],
       bymonthday => [ 3, 13 ]  );

    @dt = $set->as_list( start => $dt1,
                         end => $dt1->clone->add( years => 1 ) );
    $r = join(' ', map { $_->datetime } @dt);
    is( $r,
        '2003-12-03T12:10:45 2003-12-13T12:10:45 '.
        '2004-02-03T12:10:45 2004-02-13T12:10:45',
        "yearly, dtstart, bymonthday, bymonth" );

    # YEARLY BYWEEKNO
    $set = DateTime::Event::ICal->recur( 
       freq =>       'yearly',
       dtstart =>    $dt1,
       byweekno =>    [ 2, 12 ],
    );

    @dt = $set->as_list( start => $dt1,
                         end => $dt1->clone->add( years => 1 ) );
    $r = join(' ', map { $_->datetime } @dt);
    is( $r,
        '2004-01-08T12:10:45 2004-03-18T12:10:45',
        "yearly, dtstart, byweekno" );

}
