//
//  CardDetailViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 22/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "CardDetailViewController.h"
#import "CardDetailEditViewController.h"


@implementation CardDetailViewController
@synthesize card;
@synthesize frontSide, flipSide, lblDeck, lblExpired;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = [self editButtonItem];
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
}


#pragma mark -
#pragma mark  Events

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	CardDetailEditViewController *cardDetailEdit = [[CardDetailEditViewController alloc] initWithNibName:@"CardDetailEdit"
																								  bundle:nil];
	cardDetailEdit.card = self.card;
	[cardDetailEdit setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[cardDetailEdit setViewClosedCallbackWithTarget:self andSelector:@selector(cardDetailClosed)];
	[self presentModalViewController:cardDetailEdit animated:YES];
}

- (void)cardDetailClosed
{
	self.flipSide.text = self.card.flipSide;
	// Save the new flip side
	[self.card setFlipSideAndNotify:self.flipSide.text];
}


#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload
{
	self.frontSide = nil;
	self.flipSide = nil;
	self.lblDeck = nil;
	self.lblExpired = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
	[frontSide release];
	[flipSide release];
	[lblDeck release];
	[lblExpired release];
    [super dealloc];
}


@end
