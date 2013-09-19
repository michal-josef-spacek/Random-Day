# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Class for random day generation';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'Random-Day';
requires 'Class::Utils' => 0.03;
requires 'DateTime' => 0;
requires 'DateTime::Event::Random' => 0;
requires 'DateTime::Event::Recurrence' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Random-Day';
resources 'homepage' => 'https://github.com/tupinek/Random-Day';
resources 'repository' => 'git://github.com/tupinek/Random-Day';
test_requires 'English' => 0;
test_requires 'File::Object' => 0.05;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.02';

# Run.
WriteAll();
