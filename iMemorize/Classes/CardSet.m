//
//  CardSet.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 20/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "CardSet.h"
#import "JmemorizeCsvFileParser.h"


@implementation CardSet

@synthesize cards;

- (id)initWithFile:(NSString *)path
{
	self = [self init];
	[self loadCardsFromFile:path];
	
	return self;
}

- (void)loadCardsFromFile:(NSString *)path
{
	NSString *dataFile = [NSString stringWithContentsOfFile:path
												   encoding:NSUTF8StringEncoding
													  error:NULL];
	cards = [JmemorizeCsvFileParser parseCardsFromData:dataFile];
	[cards retain];
}

- (void)dealloc
{
	[cards release];
	[super dealloc];
}

@end
