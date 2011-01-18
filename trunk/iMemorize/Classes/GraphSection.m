//
//  GraphSection.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 13/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import "GraphSection.h"


@implementation GraphSection

@synthesize color, size;

- (id)initWithColor:(UIColor *)initColor size:(int)initSize
{
	if (self = [super init]) {
		self.color = initColor;
		self.size = initSize;
	}
	
	return self;
}

- (void)dealloc
{
	[color release];
	[super dealloc];
}

@end
