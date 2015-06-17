#! /usr/bin/perl
use strict;

# A my declares the listed variables to be local 
my @runlist= ("Pca21","P21c","P21m"."P42nmc","Pbca","Pmn21","Pnma");

# iterate over folders
foreach my $run (@runlist) {
mkdir $run;
#system("cp", "PBS_sub", $run);
chdir($run) or die "$!";

# Read file <
open(FILE, "<../PBS_sub") || die "File not found";
my @lines = <FILE>;
close(FILE);

# Performing a regex search-and-replace: $string =~ s/regex/replacement/g;
my @newlines;
foreach(@lines) {
   $_ =~ s/000/$run/g;
   # •push EXPR,LIST Treats ARRAY as a stack by appending the values of LIST to the end of ARRAY
   push(@newlines,$_);
}

# output a new pbs submission script specific for the folder
open(FILE, ">PBS_sub1") || die "File not found";
print FILE @newlines;
close(FILE);

# submit the PBS script
system("qsub", "PBS_sub1");
chdir('..') or die "$!";
}
