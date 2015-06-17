#! /usr/bin/perl
use strict;
my @runlist= ("Pca21","P21c","P21m"."P42nmc","Pbca","Pmn21","Pnma");
my @newlines;
my $find="TOTEN";

### remove all directories
#foreach my $run (@runlist) {
#system("rm","-r",$run);
#}

#### collect all OUTCAR files in the folder outfile
#mkdir "outfile";
#foreach my $run (@runlist) {
#	chdir($run) or die "$!";
#	# . for concatenation of strings
#	system("cp", "./OUTCAR", "../outfile/".$run.".out");
#	chdir('..') or die "$!";
#}

##### postprocess OUTCAR files in the folder outfile
chdir("outfile") or die "$!";
foreach my $run (@runlist) {
	open(FILE, "./".$run.".out") || die "File not found";
	my @lines = <FILE>;
	close(FILE);

	push(@newlines,"$run\n");
	foreach(@lines) {
		if ($_ =~ /$find/) {
			# •push EXPR,LIST Treats ARRAY as a stack by appending the values of LIST to the end of ARRAY
			push(@newlines,$_);        
		}  
	}
}

# output the matching line in a new file
open(FILE, ">out.txt") || die "File not found";
print FILE @newlines;
close(FILE);
chdir('..') or die "$!";
### end of postprocessing


