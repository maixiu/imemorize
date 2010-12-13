//
//  LearnSettingsViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 03/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "LearnSettingsViewController.h"
#import "LearnViewController.h"
#import "Card.h"

@implementation LearnSettingsViewController

@synthesize lblNbCardsToLearn, scCardsToLearn, set;


#pragma mark -
#pragma mark Events

- (IBAction)nbCardsToLearnValueChanged:(id)sender
{
	UISlider *slider = sender;
	int value = (int)slider.value;
	self.lblNbCardsToLearn.text = [NSString stringWithFormat:@"%d", value - value%5];
}

- (IBAction)startTouchUpInside:(id)sender
{
	int nbCardsToLearn = [self.lblNbCardsToLearn.text intValue];
	BOOL isKnown = self.scCardsToLearn.selectedSegmentIndex == 1;
	NSArray *cardsToLearn = [self.set getCardsToLearn:nbCardsToLearn thatAreKnown:isKnown];
	
	LearnViewController *learn = [[LearnViewController alloc] initWithNibName:@"Learn" bundle:nil];
	learn.cards = cardsToLearn;
	learn.delegate = self;
	[learn setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[self presentModalViewController:learn animated:YES];
	
	[learn release];
}


#pragma mark -
#pragma mark LearnViewDelegate

- (void)cardsUpdated:(NSArray *)cards
{
	[self.set updateCards:cards];
}


#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    [super viewDidUnload];
    self.lblNbCardsToLearn = nil;
	self.scCardsToLearn = nil;
}


- (void)dealloc {
    [super dealloc];
	[lblNbCardsToLearn release];
	[scCardsToLearn release];
	[set release];
}


@end
