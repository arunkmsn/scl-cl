#!/usr/bin/env perl
use strict;
use warnings;
require "/home/vagrant/scl/paths.pl";
require "$GlblVar::SCLINSTALLDIR/converters/convert.pl";

#Declaration of all the variables
my $word;
my $word_wx="";
my $ans="";
my $encoding="Unicode";
my $rt;
my $rt_XAwu_gaNa;
my $XAwu;
my $gaNa;
my $lifga;
my $link;
my $upasarga;
my $prayogaH;
my $color;

$word=$ARGV[0];
$encoding=$ARGV[1];
$word_wx = &convert($encoding,$word,$GlblVar::SCLINSTALLDIR);
chomp($word_wx);
chdir("$GlblVar::SCLINSTALLDIR/SHMT");
$ans = `./prog/morph/webrun_morph.sh $word_wx`;
$ans = join "\n", split("/", $ans);
print STDOUT $ans;
