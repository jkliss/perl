#!/usr/bin/perl

use strict;
use warnings;

open(SEQ, "testsequenzen");
my @seq = <SEQ>;
my @xseq;
my @yseq;

my $count = 0;
my $element_number = 0;
foreach my $element_seq (@seq)
{
	while(substr($element_seq, $count, 1) =~ m/[A-Z]/g)
	{
		if($element_number == 0)
		{
			push(@xseq, substr($element_seq, $count, 1));
		}
		if($element_number == 1)
		{
			push(@yseq, substr($element_seq, $count, 1));
		}
		$count++;
	}
	$count = 0;
	$element_number++;
}

my @sep_char = (\@xseq, \@yseq);
print @{$sep_char[0]};
print "\n";
print @{$sep_char[1]};
print "\n";

my @yaxis;
### 
for(my $y_count = 0; $y_count <= $#yseq; $y_count++)
{
	my @xaxis;
	for(my $x_count = 0; $x_count <= $#xseq; $x_count++)
	{
		if($xseq[$x_count] eq $yseq[$y_count])
		{
			push(@xaxis, 1);
		}
		else
		{
			push(@xaxis, 0);
		}
	}
	push(@yaxis, \@xaxis);
}



### Printen der Tabelle in Datei dots.out
open(OUT, ">", "dots.out");
for(my $elq = 0; $elq <= $#yaxis; $elq++)
{
	for(my $ele = 0; $ele <= $#{$yaxis[0]}; $ele++)
	{
		print OUT @{$yaxis[$elq]}[$ele];
	}
	print OUT "\n";
}


my $fnd = 0;
my $n_fnd = 0;
my $x_count = 0;
my $y_count = 0;
my $score = 0;
my @hitlist;
my @xaxis = @{$yaxis[0]};

while($y_count <= $#yaxis && $x_count <= $#xaxis)
{
	if(defined(@{$yaxis[$y_count]}[$x_count]) && @{$yaxis[$y_count]}[$x_count] == 1)
	{
		push(@hitlist, $x_count.":".$y_count);
		#Erhöhen von Achsen um 1
		
		$x_count++;
		$y_count++;
		$score++;
	}
	else
	{
		my $mod = 1;
		while($fnd == 0 && $mod < 5)
		{
			if(defined(@{$yaxis[$y_count+$mod]}[$x_count]) && @{$yaxis[$y_count+$mod]}[$x_count] == 1)
			{
				$y_count += $mod;
				$fnd = 1;
				#Treffer + fnd = 1
			}
			else
			{
				if(defined(@{$yaxis[$y_count]}[$x_count+$mod]) && @{$yaxis[$y_count]}[$x_count+$mod] == 1)
				{
					$x_count += $mod;
					$fnd = 1;
					#Treffer + fnd = 1
				}
			}
			$mod++;

		}
		if($fnd == 1)
		{
			push(@hitlist, $x_count.":".$y_count);
			$x_count++;
			$y_count++;
			#Ausgabe der Achsen und erhöhen um 1	
			$score++;
			$fnd = 0;
		}
		else
		{
			$x_count++;
			$y_count++;
		}
	}
}

print "\n##############################################################\n";
print "Positions of matches:\n";
foreach my $pair (@hitlist)
{
	print $pair." ";
}
## Jeweils paarweise 
print "\nScore: $score\n";
print "##############################################################\n";

### Seqs inklusive Gaps
my $seq_gap1 = "";
my $seq_gap2 = "";
my $posx = 0;
my $posy = 0;
my $hitlist_cnt = 0;
my @seq_tmp = split(":", $hitlist[0]);

while($posx <= $#xseq or $posy <= $#yseq)
{
	print $hitlist_cnt."\t$posx\t$posy\n";
	@seq_tmp = split(":", $hitlist[$hitlist_cnt]);
	if($seq_tmp[0] == $posx && $seq_tmp[1] == $posy)
	{
		$hitlist_cnt++;
	}
	if($seq_tmp[0] == $posx && $seq_tmp[1] == $posy)
	{
		$seq_gap1 .= $xseq[$posx];
		$seq_gap2 .= $yseq[$posy];
		$posx++;
		$posy++;
	}
	elsif($seq_tmp[1] > $posy)
	{
		$seq_gap1 .= "-";
		$seq_gap2 .= $yseq[$posy];
		$posy++;
	}
	elsif($seq_tmp[0] > $posx)
	{
		$seq_gap2 .= "-";
		$seq_gap1 .= $xseq[$posx];
		$posx++;
	}
	if($#hitlist <= $hitlist_cnt)
	{
		if($posx <= $#xseq) 
		{
			$seq_gap1 .= $xseq[$posx];
			$posx++;
		}
		if($posy <= $#yseq)
		{
			$seq_gap2 .= $yseq[$posy];
			$posy++;
		}
	}
}
#for(my $strc = 0; $strc <= $#hitlist; $strc++)
#{
	#my @seq_tmp = split(":", $hitlist[$strc]);
	#if($seq_tmp[0] == $seq_tmp[1])
	#{
		#$seq_gap1 .= $xseq[$strc];
		#$seq_gap2 .= $yseq[$strc];
	#}
	#if($seq_tmp[0] < $seq_tmp[1])
	#{
		#$seq_gap1
	#}
#}
print "\n";
print $seq_gap1."\n";
print $seq_gap2."\n";
