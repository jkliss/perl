#!/usr/bin/perl


use strict;
use warnings;

open(FILE1, $ARGV[0]);
open(FILE2, $ARGV[1]);

my @file1 = <FILE1>;
my @file2 = <FILE2>;
chomp(@file1);
chomp(@file2);
my $match = "";
my $ident = 0;
my $sim = 0;


for(my $ln = 0; $ln <= $#file1; $ln++)
{
	if(substr($file1[$ln], 0, 1) ne ">")
	{
		print "$file1[$ln]\n";
		print "$file2[$ln]\n";
		for(my $pos = 0; $pos < length($file1[$ln]); $pos++)
		{
			if(substr($file1[$ln], $pos, 1) eq substr($file2[$ln], $pos, 1))
			{
				$match .= "*";
				$ident++;
			}
			else
			{
				$match .= " ";
			}
		}
		print "$match\n";
		$match = "";
	}

}
	print "Identity: $ident\n";
