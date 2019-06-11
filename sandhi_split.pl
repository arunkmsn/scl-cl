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
    
my $word=$ARGV[0];
my $sandhi_type=$ARGV[1];
my $encoding=$ARGV[2];

chdir("$GlblVar::SCLINSTALLDIR/SHMT");
system("./prog/sandhi_splitter/web_interface/callsandhi_splitter.pl $GlblVar::SCLINSTALLDIR $encoding $word $sandhi_type $$");
print `/bin/cat $GlblVar::TFPATH/seg_$$/most_probable_output_utf.txt`, "\n\n";
print `/bin/cat $GlblVar::TFPATH/seg_$$/all_possible_outputs.txt`;

