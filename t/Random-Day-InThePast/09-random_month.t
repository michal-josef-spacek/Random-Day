use strict;
use warnings;

use English qw(-no_match_vars);
use Error::Pure::Utils qw(clean);
use Random::Day::InThePast;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Random::Day::InThePast->new;
my $ret = $obj->random_month(10);
isa_ok($ret, 'DateTime');
like($ret, qr{^\d\d\d\d-10-\d\dT00:00:00$},
	'Random date for concrete month.');

# Test.
$obj = Random::Day::InThePast->new;
eval {
	$obj->random_month(40);
};
is($EVAL_ERROR, "Cannot create DateTime object.\n",
	'Cannot create DateTime object.');
clean();
