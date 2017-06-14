package card_deck;

#-------------------------------------------------------------#
# M Kelly
#
# 13/06/2017
#
#-------------------------------------------------------------#

use strict;
no warnings 'all';

my @SUIT = ('HEARTS', 'CLUBS', 'SPADES', 'DIAMONDS');
my @FACE = ('ACE', 'KING', 'QUEEN', 'JACK');

sub new {
	my ( $class ) = shift;

	my $self = {};
	$self->{'cardDeck'} = &_fill();
	bless $self, $class;

	return $self;
 }

#-------------------------------------------------------------#

sub _fill {
	my @cardDeck;

	foreach my $suit ( @SUIT ){
		foreach my $face ( @FACE ){
	 		push @cardDeck, $face.' '.$suit;
		}
		for ( my $i=2;$i<=10;$i++ ){
			push @cardDeck, $i.' '.$suit;
	 	}
	}

	return \@cardDeck;
}

#-------------------------------------------------------------#

sub shuffle {
	my ( $self ) = @_;

	my @tempDeck = values $self->{'cardDeck'};
	my @shuffDeck;

	for(my $i=0;$i<=51;$i++){
		my $size = scalar @tempDeck;
		my $el = int(rand($size));
		$shuffDeck[$i] = $tempDeck[$el];
		splice @tempDeck, $el, 1;
	}

	$self->{'cardDeck'} = ();
	$self->{'cardDeck'} = \@shuffDeck;
}

#-------------------------------------------------------------#

1;
