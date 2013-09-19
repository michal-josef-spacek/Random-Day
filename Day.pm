package Random::Day;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use DateTime;
use DateTime::Event::Random;
use DateTime::Event::Recurrence;

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Day.
	$self->{'day'} = undef;

	# DateTime object from.
	$self->{'dt_from'} = DateTime->new(
		'year' => 1900,
	);

	# DateTime object to.
	$self->{'dt_to'} = DateTime->new(
		'year' => 2050,
	);

	# Month.
	$self->{'month'} = undef;

	# Year.
	$self->{'year'} = undef;

	# Process parameters.
	set_params($self, @params);

	return $self;
}

# Get DateTime object with random date.
sub get {
	my ($self, $date) = @_;
	if ($self->{'year'}) {
		if ($self->{'month'}) {
			if ($self->{'day'}) {
				$date = $self->random_day_month_year(
					$self->{'day'},
					$self->{'month'},
					$self->{'year'},
				);
			} else {
				$date = $self->random_month_year(
					$self->{'month'},
					$self->{'year'},
				);
			}
		} else {
			if ($self->{'day'}) {
				$date = $self->random_day_year(
					$self->{'day'},
					$self->{'year'},
				);
			} else {
				$date = $self->random_year($self->{'year'});
			}
		}
	} else {
		if ($self->{'month'}) {
			if ($self->{'day'}) {
				$date = $self->random_day_month(
					$self->{'day'},
					$self->{'month'},
				);
			} else {
				$date = $self->random_month($self->{'month'});
			}
		} else {
			if ($self->{'day'}) {
				$date = $self->random_day($self->{'day'});
			} else {
				$date = $self->random;
			}
		}
	}
	return $date;
}

# Random DateTime object for day.
sub random {
	my $self = shift;
	my $daily = DateTime::Event::Recurrence->daily;
	return $daily->next($self->_range);
}

# Random DateTime object for day defined by day.
sub random_day {
	my ($self, $day) = @_;
	my $monthly_day = DateTime::Event::Recurrence->monthly(
		'days' => $day,
	);
	return $monthly_day->next($self->random);
}

# Random DateTime object for day defined by day and month.
sub random_day_month {
	my ($self, $day, $month) = @_;
	my $yearly_day_month = DateTime::Event::Recurrence->yearly(
		'days' => $day,
		'months' => $month,
	);
	return $yearly_day_month->next($self->random);
}

# DateTime object for day defined by day, month and year.
sub random_day_month_year {
	my ($self, $day, $month, $year) = @_;
	return DateTime->new(
		'day' => $day,
		'month' => $month,
		'year' => $year,
	);
}

# Random DateTime object for day defined by month.
sub random_month {
	my ($self, $month) = @_;
	my $random_day = $self->_range;
	return $self->random_month_year($month, $random_day->year);
}

# Random DateTime object for day defined by month and year.
sub random_month_year {
	my ($self, $month, $year) = @_;
	my $daily = DateTime::Event::Recurrence->daily;
	return $daily->next(DateTime::Event::Random->datetime(
		'after' => DateTime->new(
			'day' => 1,
			'month' => $month,
			'year' => $year,
		),
		'before' => DateTime->new(
			'day' => 31,
			'month' => $month,
			'year' => $year,
		),
	));
}

# Random DateTime object for day defined by year.
sub random_year {
	my ($self, $year) = @_;
	my $daily = DateTime::Event::Recurrence->daily;
	return $daily->next(DateTime::Event::Random->datetime(
		'after' => DateTime->new(
			'day' => 1,
			'month' => 1,
			'year' => $year,
		),
		'before' => DateTime->new(
			'day' => 31,
			'month' => 12,
			'year' => $year,
		),
	));
}

# Random date in range.
sub _range {
	my $self = shift;
	return DateTime::Event::Random->datetime(
		'after' => $self->{'dt_from'},
		'before' => $self->{'dt_to'},
	);
}

1;
