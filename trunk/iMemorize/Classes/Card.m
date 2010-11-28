//
//  Card.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "Card.h"


@implementation Card

@synthesize frontSide, flipSide;

+ (id)cardWithFrontSide:(NSString *)front flipSide:(NSString *)flip
{
	Card *newCard = [[[self alloc] init] autorelease];
	newCard.frontSide = front;
	newCard.flipSide = flip;
	
	return newCard;
}

- (void)dealloc
{
	[frontSide release];
	[flipSide release];
	[super dealloc];
}

@end
