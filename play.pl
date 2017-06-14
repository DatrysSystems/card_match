#!/usr/bin/perl

#-------------------------------------------------------------#
# M Kelly
#
# 13/06/2017
#
#-------------------------------------------------------------#

use strict;
use card_deck;
no warnings 'all';

&readArg();

#-------------------------------------------------------------#

sub readArg {
	my ($num, $mode);
	do {
		print("Enter number of decks [integer] > ");
		chop($_ = <>);
		$num = $_;
	} while ($_ !~ /\d+/ && $_ < 1);
	do {
	    print("\nEnter play mode [suit, face, both or quit] > ");
	    chop($_ = <>);
			$mode = $_;
	} while ($_ ne "suit" && $_ ne 'face' && $_ ne 'both' && $_ ne 'quit');
	&_play($num, $mode);
}

#-------------------------------------------------------------#

sub _play {
	my ($num, $mode) = @_;

	my (@playerOneTot, @playerTwoTot);

	if ( $mode eq 'quit' ){
		print "\nExiting...\n";
		exit;
	}

	print "\n-----------------------------------------------------------------------\n";

	for (1 .. $num){
		my $deck1 = card_deck->new();
		my $deck2 = card_deck->new();

		$deck1->shuffle();
		$deck2->shuffle();

		my @arr1 = values %{$deck1}{'cardDeck'};
		my @arr2 = values %{$deck2}{'cardDeck'};

		my $tot = 0;

		for( my $i=0; $i<=51; $i++ ){

			my ($play1, $play2);

			my @deck1 = split / /, $arr1[$i];
			my @deck2 = split / /, $arr2[$i];

			if ( $mode eq 'face' ) {
				$play1 = @deck1[0];
				$play2 = @deck2[0];
			}
			elsif ( $mode eq 'suit' ) {
				$play1 = @deck1[1];
				$play2 = @deck2[1];
			}
			else {
				$play1 = $arr1[$i];
				$play2 = $arr2[$i];
			}

			if ( $play1 eq $play2 ){
				my $player = int(rand(2))+1;
				if ( $player == 1 ){
					print "Match! [$play1 : element [$i]] : Player 1 gains ".($tot+1)." cards...\n";
					my @tmpArr =  splice @arr2, 0, $tot;
					push @arr1, @tmpArr;
				}
				else {
					print "Match! [$play2 : element [$i]] : Player 2 gains ".($tot+1)." cards...\n";
					my @tmpArr =  splice @arr1, 0, $tot;
					push @arr2, @tmpArr;
				}
			}
			$tot++;
		}
		push @playerOneTot, @arr1;
		push @playerTwoTot, @arr2;
	 }

	 print "-----------------------------------------------------------------------\n";

	 my $size1 = scalar @playerOneTot;
	 my $size2 = scalar @playerTwoTot;

	 if ( $size1 > $size2 ) {
	 	print "\nPLAYER 1 WINS! [$size1] (player 2 left with $size2 cards)\n";
	 }
	 elsif ( $size1 < $size2 ) {
	  print "\nPLAYER 2 WINS! [$size2] (player 1 left with $size1 cards)\n";
 	 }
 	 else {
	  print "\nPLAYER 1 [$size1] DRAWS with PLAYER 2 [$size2]!\n";
 	 }

	 print "\n-----------------------------------------------------------------------\n";

}

#-------------------------------------------------------------#
