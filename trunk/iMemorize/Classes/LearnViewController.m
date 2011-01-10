//
//  LearnViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 04/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <stdlib.h>
#import "LearnViewController.h"
#import "Card.h"
#import "Constants.h";
#import "CardDetailEditViewController.h"


@interface LearnViewController()
@property int currentCardIndex;
@property int totalCardsCount;

- (void)showAnswer:(BOOL)show;
- (void)showNextShuffleCardAndRemoveCurrent:(BOOL)removeCurrent;
- (void)updateProgress:(int)nbCardsLearn withTotalCount:(int)totalCount;
@end


@implementation LearnViewController

@synthesize cards;
@synthesize progressView, lblProgress, lblFront, txtFlip;
@synthesize btnCancel, btnAnswer, btnYes, btnNo, btnClose;
@synthesize currentCardIndex, totalCardsCount;
@synthesize delegate;


#pragma mark -
#pragma mark Initialization

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.totalCardsCount = self.cards.count;
	self.txtFlip.hidden = YES;
	[self showNextShuffleCardAndRemoveCurrent:NO];
	[self updateProgress:0 withTotalCount:self.cards.count];
}


#pragma mark -
#pragma mark Events

- (IBAction)btnCancelTouchUpInside:(id)sender
{
	[self.delegate cardsUpdated:self.cards];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnCloseTouchUpInside:(id)sender
{
	[self.delegate cardsUpdated:self.cards];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnAnswerTouchUpInside:(id)sender
{
	[self showAnswer:YES];
}

- (IBAction)btnYesTouchUpInside:(id)sender
{
	[self showAnswer:NO];
	
	//La carte est mise dans le deck suivant
	Card *card = [self.cards objectAtIndex:self.currentCardIndex];
	card.deck++;
	if (card.deck > kMaxDeckCount)
		card.deck = kMaxDeckCount;
		
	[card reschedule];
	[self showNextShuffleCardAndRemoveCurrent:YES];
	[self updateProgress:self.totalCardsCount - self.cards.count
		  withTotalCount:self.totalCardsCount];
}

- (IBAction)btnNoTouchUpInside:(id)sender
{
	[self showAnswer:NO];
	
	//La carte est mise dans le 1er deck
	Card *card = [self.cards objectAtIndex:self.currentCardIndex];
	card.deck = 0;
	
	[card reschedule];
	[self showNextShuffleCardAndRemoveCurrent:NO];
}

- (IBAction)btnEditClicked:(id)sender
{
	Card *card = [self.cards objectAtIndex:self.currentCardIndex];
	CardDetailEditViewController *cardDetailEdit = [[CardDetailEditViewController alloc] initWithNibName:@"CardDetailEdit"
																								  bundle:nil];
	cardDetailEdit.card = card;
	[cardDetailEdit setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[cardDetailEdit setViewClosedCallbackWithTarget:self andSelector:@selector(cardDetailClosed)];
	[self presentModalViewController:cardDetailEdit animated:YES];
}

- (void)cardDetailClosed
{
	Card *card = [self.cards objectAtIndex:self.currentCardIndex];
	self.txtFlip.text = card.flipSide;
	// Save the new flip side
	[card setFlipSideAndNotify:self.txtFlip.text];
}

#pragma mark -
#pragma mark Private methods

- (void)showAnswer:(BOOL)show
{
	self.btnAnswer.hidden = show;
	self.btnCancel.hidden = show;
	self.btnYes.hidden = !show;
	self.btnNo.hidden = !show;
	self.txtFlip.hidden = !show;
}

- (void)showNextShuffleCardAndRemoveCurrent:(BOOL)removeCurrent
{
	if (removeCurrent && self.cards.count > 0) {
		NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:self.cards.count - 1];
		for (int i = 0; i < self.cards.count; i++) {
			if (i != self.currentCardIndex) {
				[newArray addObject:[self.cards objectAtIndex:i]];
			}
		}
		
		self.cards = newArray;
	}
	
	if (self.cards.count > 0) {
		self.currentCardIndex = arc4random() % self.cards.count;
		
		Card *card = [self.cards objectAtIndex:self.currentCardIndex];
		self.lblFront.text = card.frontSide;
		self.txtFlip.text = card.flipSide;
	}
	else {
		self.lblFront.text = @"完了！";
		self.txtFlip.text = @"La série est finie, vous pouvez fermer la fenêtre.";
		self.txtFlip.hidden = NO;
		self.btnCancel.hidden = YES;
		self.btnAnswer.hidden = YES;
		self.btnYes.hidden = YES;
		self.btnNo.hidden = YES;
		self.btnClose.hidden = NO;
	}
}

- (void)updateProgress:(int)nbCardsLearnt withTotalCount:(int)totalCount
{
	float progress = (float)nbCardsLearnt/(float)totalCount;
	self.lblProgress.text = [NSString stringWithFormat:@"%d/%d", nbCardsLearnt, totalCount];
	self.progressView.progress = progress;
}


#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    [super viewDidUnload];
	self.progressView = nil;
	self.lblProgress = nil;
	self.lblFront = nil;
	self.txtFlip = nil;
	self.btnCancel = nil;
	self.btnAnswer = nil;
	self.btnYes = nil;
	self.btnNo = nil;
	self.btnClose = nil;
}

- (void)dealloc {
    [super dealloc];
	[progressView release];
	[lblProgress release];
	[lblFront release];
	[txtFlip release];
	[btnCancel release];
	[btnAnswer release];
	[btnYes release];
	[btnNo release];
	[btnClose release];
}

@end
