//
//  GraphViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 12/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "Deck.h"


@implementation GraphViewController

@synthesize graphView, set;

- (void)initData
{
	for (Deck *deck in self.set.decks) {
		NSArray *cardsExpired = [deck getCardsExpired];
		
		// Create deck bar
		[self.graphView addBarWithIndex:deck.position
								section:0
								  color:[UIColor greenColor]
								   size:(deck.cards.count - cardsExpired.count)];
		[self.graphView addBarWithIndex:deck.position
								section:1
								  color:[UIColor redColor]
								   size:cardsExpired.count];
	}
}

- (void)loadView {
	GraphView *graph = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, 320, 411)];
	self.graphView = graph;
	
	[self initData];
	self.view = graph;
	[graph release];
}


#pragma mark -
#pragma mark CardSetDelegate

- (void)cardsUpdated:(id)sender
{
	[self.graphView reinitData];
	[self initData];
	[self loadView];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[set release];
    [super dealloc];
}


@end
