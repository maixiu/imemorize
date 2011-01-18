//
//  GraphBar.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 13/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import "GraphBar.h"
#import "GraphSection.h"


@implementation GraphBar

@synthesize sections;

- (id)init
{
	if (self = [super init]) {
		self.sections = [NSMutableArray array];
	}
	
	return self;
}

- (void)addSectionWithIndex:(int)index color:(UIColor *)color size:(int)size
{
	for (int i = self.sections.count; i <= index; i++) {
		GraphSection *section = [[GraphSection alloc] init];
		[self.sections addObject:section];
		[section release];
	}
	
	GraphSection *section = [self.sections objectAtIndex:index];
	section.color = color;
	section.size = size;
}

- (int)totalSize
{
	int total = 0;
	for (GraphSection *section in self.sections) {
		total += section.size;
	}
	
	return total;
}

- (void)dealloc
{
	[sections release];
	[super dealloc];
}

@end
