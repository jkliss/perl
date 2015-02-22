#!/usr/bin/perl

use strict;
use warnings;

open(PKT, "testmatrix") or die "Datei nicht gefunden\n";
my @mata = <PKT>;
my $x = 0;
my $y = 0;

while(($x == $#mata) && ($y == length($mata[0])))
{
	
