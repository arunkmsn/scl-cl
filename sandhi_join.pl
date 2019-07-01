#!/usr/bin/env perl

use strict;
use warnings;

require "/home/vagrant/scl/paths.pl";
chdir("$GlblVar::SCLINSTALLDIR/sandhi");
require "$GlblVar::SCLINSTALLDIR/converters/convert.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/sandhi.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/apavAxa_any.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/any_sandhi.pl";

my $filename=$ARGV[0];
my $encoding=$ARGV[1];

open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";

while (my $line=<$fh>) {

  my @words = split(/:/, $line);
  my $word1 = $words[0];
  my $word2 = $words[1];
  my $sandhi_type = "any";

  my $word1_wx=&convert($encoding, $word1, $GlblVar::SCLINSTALLDIR);
  chomp($word1_wx);

  my $word2_wx=&convert($encoding, $word2, $GlblVar::SCLINSTALLDIR);
  chomp($word2_wx);

  my $ans = &sandhi($word1_wx, $word2_wx);

  my @ans=split(/,/, $ans);
  my @padas = split(/:/, $ans[0]);
  my @analysis = split(/:/, $ans[1]);
  my @sutra = split(/:/, $ans[2]);

  my $str = "";
  for (my $i = 0; $i < @padas; $i += 1) {
       my $pada = $padas[$i];
       my $ana = $analysis[$i];
       my $sut = $sutra[$i];
       $str = $str . $pada . "\t\t\t" . $ana . "\t\t\t" . $sut . "\n";
  }

  my $strn = $word1_wx . " + " . $word2_wx . " = \n" . $str;

  my $cmd = "echo \"$strn\" | $GlblVar::SCLINSTALLDIR/converters/ri_skt | $GlblVar::SCLINSTALLDIR/converters/iscii2utf8.py 1";
  my $san = `$cmd`;
  print $san;
}
