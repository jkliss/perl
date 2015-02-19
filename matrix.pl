#!/usr/bin/perl

use strict;
use warnings;

open(MATRIX, "blosum62") or die "Datei nicht gefunden\n";

my @rawMAT = <MATRIX>;
my @MAT;

foreach my $k (@rawMAT)
{
	if(substr($k, 0, 1) ne "#")
	{
		push(@MAT, $k);
	}
}

foreach my $k (@MAT)
{
	my @splits = split(" ", $k);
	foreach my $i (@splits)
	{
		print $i;
	}
}


