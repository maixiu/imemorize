//
//  Deck.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 08/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "Deck.h"
#import "Card.h"


@implementation Deck

@synthesize cards, position;


#pragma mark -
#pragma mark Initialization

+ (id)deckWithPosition:(int)newPosition
{
	Deck *newDeck = [[[Deck alloc] init] autorelease];
	newDeck.position = newPosition;
	return newDeck;
}


#pragma mark -
#pragma mark Methods

- (NSArray *)getCardsExpired
{
	NSMutableArray *cardsExpired = [NSMutableArray arrayWithCapacity:self.cards.count];
	for (Card *card in self.cards) {
		if ([card isExpired]) {
			[cardsExpired addObject:card];
		}
	}
	
	return cardsExpired;
}

- (BOOL)isExpired
{
	for (Card *card in self.cards) {
		if ([card isExpired]) {
			return YES;
		}
	}
	
	return NO;
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.cards forKey:kCodingCardsKey];
	[aCoder encodeInt:self.position forKey:kCodingPosition];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super init]) {
		self.cards = [aDecoder decodeObjectForKey:kCodingCardsKey];
		self.position = [aDecoder decodeIntForKey:kCodingPosition];
	}
	
	return self;
}


@end
