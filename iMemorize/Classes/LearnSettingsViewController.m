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

@synthesize lblNbCardsToLearn, scCardsToLearn, cards;


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
	NSMutableArray *cardsToLearn = [NSMutableArray arrayWithCapacity:self.cards.count];
	int nbCardsToLearn = [self.lblNbCardsToLearn.text intValue];
	
	for (Card *card in self.cards) {
		BOOL isExpired = [card.expired compare:[NSDate dateWithTimeIntervalSinceNow:0]] == NSOrderedAscending;
		//Si unlearned est sélectionné || si expired est sélectionné
		if ((self.scCardsToLearn.selectedSegmentIndex == 0 && card.deck == 0) ||
			(self.scCardsToLearn.selectedSegmentIndex == 1 && isExpired))
		{
			[cardsToLearn addObject:card];
			if (cardsToLearn.count == nbCardsToLearn) {
				break;
			}
		}
	}

	LearnViewController *learn = [[LearnViewController alloc] initWithNibName:@"Learn" bundle:nil];
	learn.cards = cardsToLearn;
	[learn setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[self presentModalViewController:learn animated:YES];
	[learn release];
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
}


@end
