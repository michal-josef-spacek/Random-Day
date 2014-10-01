# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use Error::Pure::Utils qw(clean);
use Random::Day;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Random::Day->new;
my $ret = $obj->random_day_month_year(10, 10, 2014);
isa_ok($ret, 'DateTime');
like($ret, qr{^2014-10-10T00:00:00$},
	'Right date from day, month and year informations.');

# Test.
eval {
	$obj->random_day_month_year(40, 10, 2014);
};
is($EVAL_ERROR, "Cannot create DateTime object.\n",
	'Cannot create DateTime object.');
clean();
