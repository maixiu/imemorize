//
//  NSArrayShuffle.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 15/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "NSArrayShuffle.h"


@implementation NSArray(Shuffle)

-(NSArray *)shuffledArray
{
	
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	
	NSMutableArray *copy = [self mutableCopy];
	while ([copy count] > 0)
	{
		int index = arc4random() % [copy count];
		id objectToMove = [copy objectAtIndex:index];
		[array addObject:objectToMove];
		[copy removeObjectAtIndex:index];
	}
	
	[copy release];
	return array;
}

@end
