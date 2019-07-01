#!/usr/bin/env perl

require "/home/vagrant/scl/paths.pl";
require "$GlblVar::SCLINSTALLDIR/converters/convert.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/sandhi.pl";
require "./apavAxa_any.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/any_sandhi.pl";

my $filename=$ARGV[0];
my $encoding=$ARGV[1];

open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";

while (my $line=<$fh>) {
  @words = split(/:/, $line);

  $word1 = chomp($words[0]);
  $word2 = chomp($words[1]);

  $sandhi_type = "any";

  $word1_wx=&convert($encoding,$word1,$GlblVar::SCLINSTALLDIR);
  chomp($word1_wx);

  $word2_wx=&convert($encoding,$word2,$GlblVar::SCLINSTALLDIR);
  chomp($word2_wx);
      
  $ans = &sandhi($word1_wx,$word2_wx);
  @ans=split(/,/, $ans);
  @padas = split(/:/, $ans[0]);
  @analysis = split(/:/, $ans[1]);
  @sutra = split(/:/, $ans[2]);
  $str = "";
  for (my $i = 0; $i < @padas; $i += 1) {
       my $pada = @padas[$i];
       my $ana = @analysis[$i];
       $str = $str . $pada . "\t\t" . $ana . "\t\t" . $sutra . "\n";
  }
  $string = $word1_wx . " + " . $word2_wx . " = \n" .
            $str . "\n\t" . $ans[3] . "\n\t" . $ans[4] .
            "\n\t" . $ans[5] . "\n\t" . $ans[6] . "\n\t" . $ans[7];

  $cmd = "echo \"$string\" | $GlblVar::SCLINSTALLDIR/converters/ri_skt | $GlblVar::SCLINSTALLDIR/converters/iscii2utf8.py 1";
  $san = `$cmd`;
  print $san;
  $san=~s/,:/,/g;


  @san=split(/,/,$san);
  @san2=split(/:/,$san[2]);
  @san3=split(/:/,$san[3]);
  @san4=split(/:/,$san[4]);
  print @san;
  print @san2;
  print @san3;
  print @san4;
}
