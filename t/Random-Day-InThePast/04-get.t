use strict;
use warnings;

use English qw(-no_match_vars);
use Error::Pure::Utils qw(clean);
use Random::Day::InThePast;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Random::Day::InThePast->new;
my $ret = $obj->get;
like($ret, qr{^\d\d\d\d-\d\d-\d\dT00:00:00$}, 'Get on default object.');
