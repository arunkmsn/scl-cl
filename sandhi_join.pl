#!/usr/bin/env perl

require "/home/vagrant/scl/paths.pl";
require "$GlblVar::SCLINSTALLDIR/converters/convert.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/sandhi.pl";
require "./apavAxa_any.pl";
require "$GlblVar::SCLINSTALLDIR/sandhi/any_sandhi.pl";

$word1=$ARGV[0];
$word2=$ARGV[1];
$encoding=$ARGV[2];
$word1 =~ s/\r//g;
$word2 =~ s/\r//g;

chomp($word1);
chomp($word2);

$sandhi_type = "any";

$word1_wx=&convert($encoding,$word1,$GlblVar::SCLINSTALLDIR);
chomp($word1_wx);

$word2_wx=&convert($encoding,$word2,$GlblVar::SCLINSTALLDIR);
chomp($word2_wx);
      
$ans = &sandhi($word1_wx,$word2_wx);
@ans=split(/,/, $ans);
@padas = split(/:/, $ans[0]);
@analysis = split(/:/, $ans[1]);
$str = "";
for (my $i = 0; $i < @padas; $i += 1) {
     my $pada = @padas[$i];
     my $ana = @analysis[$i];
     $str = $str . $pada . "\t" . $ana . "\n";
}
$string = $word1_wx." + ".$word2_wx." = \n".$str.$ans[2]."\n\t".$ans[3]."\n\t".$ans[4]."\n\t".$ans[5]."\n\t".$ans[6]."\n\t".$ans[7]."\n\n";

$cmd = "echo \"$string\" | $GlblVar::SCLINSTALLDIR/converters/ri_skt | $GlblVar::SCLINSTALLDIR/converters/iscii2utf8.py 1";
$san = `$cmd`;
print $san;
$san=~s/,:/,/g;


@san=split(/,/,$san);
@san2=split(/:/,$san[2]);
@san3=split(/:/,$san[3]);
@san4=split(/:/,$san[4]);
