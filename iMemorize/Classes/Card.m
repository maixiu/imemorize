//
//  Card.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "Card.h"


@implementation Card

@synthesize frontSide, flipSide, deck, expired;

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInt:self.deck forKey:kDeckKey];
	[aCoder encodeObject:self.expired forKey:kExpiredKey];
	[aCoder encodeObject:self.frontSide forKey:kFrontSideKey];
	[aCoder encodeObject:self.flipSide forKey:kFlipSideKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super init]) {
		self.deck = [aDecoder decodeIntForKey:kDeckKey];
		self.expired = [aDecoder decodeObjectForKey:kExpiredKey];
		self.frontSide = [aDecoder decodeObjectForKey:kFrontSideKey];
		self.flipSide = [aDecoder decodeObjectForKey:kFlipSideKey];
	}
	
	return self;
}


#pragma mark -
#pragma mark Methods

+ (id)cardWithFrontSide:(NSString *)front flipSide:(NSString *)flip deck:(int)newDeck
{
	Card *newCard = [[[self alloc] init] autorelease];
	newCard.frontSide = front;
	newCard.flipSide = flip;
	newCard.deck = newDeck;
	newCard.expired = newDeck > 0 ? [NSDate dateWithTimeIntervalSinceNow:-1] : nil;
	
	return newCard;
}

- (void)reschedule
{
	int oneDay = 60*60*24;
	int expiredDays = 2^(self.deck - 1);
	
	self.expired = [NSDate dateWithTimeIntervalSinceNow:oneDay * expiredDays];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[frontSide release];
	[flipSide release];
	[super dealloc];
}

@end
