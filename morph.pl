#!/usr/bin/env perl

use strict;
use warnings;

require "/home/vagrant/scl/paths.pl";
require "$GlblVar::SCLINSTALLDIR/converters/convert.pl";

my $word=$ARGV[0];
my $encoding=$ARGV[1];

my $word_wx = &convert($encoding,$word,$GlblVar::SCLINSTALLDIR);
chomp($word_wx);
chdir("$GlblVar::SCLINSTALLDIR/SHMT");

my $ans = `./prog/morph/webrun_morph.sh $word_wx`;
$ans = join "\n", split("/", $ans);
print STDOUT $ans;
