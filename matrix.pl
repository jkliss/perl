#!/usr/bin/perl

use strict;
use warnings;

open(MATRIX, "blosum62") or die "Datei nicht gefunden\n";

my @rawMAT = <MATRIX>;
my @mat;
my @head = ();
my @combined;
my @rows;
my %order;
my $ordercount = 0;

### @rawMAT von # bereinigen
foreach my $k (@rawMAT)
{
	if(substr($k, 0, 1) ne "#")
	{
		push(@mat, $k);
	}
}

### durchlaufen der Matrix
for(my $k = 0; $k <= $#mat; $k++)
{
	my @splits = split(" ", $mat[$k]);
	if($k == 0)
	{
		### head Datei mit der ersten Zeile --- jeweils alle Zeichen als 1 Element
		for(my $i = 0; $i <= $#splits; $i++)
		{
			push(@head, $splits[$i]);
		}
	}
	if(!%order)
	{
		foreach my $m (@head)
		{
			$order{$head[$ordercount]} = $ordercount;
			$ordercount++;
		}
	}
	else #Alle anderen Zeilen
	{
		shift(@splits);
		push(@rows, \@splits);
	}
}


#print @{$rows[5]}[7]; #### Beispiel für das Array, 0 ist die Anzahl der Reihen exklusive head
#                              1 ist die Position im Array inklusive Buchstaben


#print @{$rows[$order{"B"}]}[$order{"C"}]  ## Beispiel für das Benutzen des Order Hashes zum zugreifen
