//
//  CardDetailViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 22/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "CardDetailViewController.h"


@implementation CardDetailViewController
@synthesize card;
@synthesize frontSide, flipSide, lblDeck, lblExpired;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIBarButtonItem *bbItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
																			target:nil
																			action:nil];
	self.navigationItem.rightBarButtonItem = bbItem;
	self.title = self.card.frontSide;
	self.frontSide.text = self.card.frontSide;
	self.flipSide.text = self.card.flipSide;
	self.lblDeck.text = self.card.deck > 0 ? [NSString stringWithFormat:@"Deck %d", self.card.deck] : @"Not learned";
	
	if ([self.card isExpired]) {
		self.lblExpired.text = @"Expired !";
	}
	else {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
		self.lblExpired.text = [dateFormatter stringFromDate:self.card.expired];
		[dateFormatter release];
	}

	[bbItem release];
}

- (void)viewDidUnload
{
	self.frontSide = nil;
	self.flipSide = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
	[frontSide release];
	[flipSide release];
    [super dealloc];
}


@end