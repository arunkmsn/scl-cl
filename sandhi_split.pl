#!/usr/bin/env perl

use strict;
use warnings;

require "/home/vagrant/scl/paths.pl";
require "$GlblVar::SCLINSTALLDIR/converters/convert.pl";

# samaasacheda
# word: ग्राममागच
# sandhi_type: S
# encoding: Unicode

# padacheda
# word: ग्राममागच्छ
# sandhi_type: s
# encoding: Unicode

# ubhaya
# word:
# sandhi_type: b
# encoding: Unicode

my $filename=$ARGV[0];
my $sandhi_type=$ARGV[1];
my $encoding=$ARGV[2];


chdir("$GlblVar::SCLINSTALLDIR/SHMT");
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";

while(my $word=<$fh>) {
  chomp($word);
  system("./prog/sandhi_splitter/web_interface/callsandhi_splitter.pl $GlblVar::SCLINSTALLDIR $encoding $word $sandhi_type $$");
  my $sandhi = `/bin/cat $GlblVar::TFPATH/seg_$$/most_probable_output_utf.txt`;
  my $others = `/bin/cat $GlblVar::TFPATH/seg_$$/all_possible_outputs.txt`;

  while($sandhi =~ /<\s*a\s*title\s*=\s*"(.*)"\s*>/) {
    $sandhi =~ s/(.*)<\s*a\s*title\s*=\s*"(.*)"\s*>(.*)/ $1 [$2] $3 /g;
  }
  while($others =~ /<\s*a\s*title\s*=\s*"(.*)"\s*>/) {
    $others =~ s/(.*)<\s*a\s*title\s*=\s*"(.*)"\s*>(.*)/ $1 [$2] $3 /g;
  }

  while($sandhi =~ /<\s*\/a\s*>/) {
    $sandhi =~ s/(.*)<\s*\/a\s*>(.*)/ $1 $2 /g;
  }
  while($others =~ /<\s*\/a\s*>/) {
    $others =~ s/(.*)<\s*\/a\s*>(.*)/ $1 $2 /g;
  }

  $sandhi =~ s/^\s+|\s+$//g;
  chop($sandhi);
  print $sandhi . "\n";
}
