//
//  Card.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "Card.h"


@interface Card()
@property (nonatomic, retain) NSMutableArray *delegates;
- (void)sendCardUpdated;
@end


@implementation Card

@synthesize frontSide, flipSide, deck, expired;
@synthesize delegates;

- (id)init
{
	if (self = [super init]) {
		self.delegates = [NSMutableArray arrayWithCapacity:5];
	}
	
	return self;
}


#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInt:self.deck forKey:kCodingDeckKey];
	[aCoder encodeObject:self.expired forKey:kCodingExpiredKey];
	[aCoder encodeObject:self.frontSide forKey:kCodingFrontSideKey];
	[aCoder encodeObject:self.flipSide forKey:kCodingFlipSideKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [self init]) {
		self.deck = [aDecoder decodeIntForKey:kCodingDeckKey];
		self.expired = [aDecoder decodeObjectForKey:kCodingExpiredKey];
		self.frontSide = [aDecoder decodeObjectForKey:kCodingFrontSideKey];
		self.flipSide = [aDecoder decodeObjectForKey:kCodingFlipSideKey];
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
	if (self.deck > 0) {
		int oneDay = 60*60*24;
		int expiredDays = pow(2, (self.deck - 1));
		self.expired = [NSDate dateWithTimeIntervalSinceNow:oneDay * expiredDays];
	}
	else {
		self.expired = nil;
	}
}

- (BOOL)isExpired
{
	if ([self.expired compare:[NSDate date]] == NSOrderedAscending) {
		return YES;
	}
	
	return NO;
}

- (void)setFlipSideAndNotify:(NSString *)newFlipSide
{
	self.flipSide = newFlipSide;
	[self sendCardUpdated];
} 

- (void)registerDelegate:(id <CardDelegate>)delegate
{
	[self.delegates addObject:delegate];
}

- (void)unSubscribeDelegate:(id <CardDelegate>)delegate
{
	[self.delegates removeObject:delegate];
}

- (void)sendCardUpdated
{
	for (id <CardDelegate> delegate in self.delegates) {
		[delegate cardUpdated:self];
	}
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
