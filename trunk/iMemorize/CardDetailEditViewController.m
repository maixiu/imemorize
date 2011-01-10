//
//  CardDetailEditViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 06/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import "CardDetailEditViewController.h"


@implementation CardDetailEditViewController

@synthesize card, textEdit;
@synthesize target, viewClosedCallback;


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.textEdit.text = self.card.flipSide;
	[self.textEdit becomeFirstResponder];
}

- (void)setViewClosedCallbackWithTarget:(id)aTarget andSelector:(SEL)aSelector
{
	self.target = aTarget;
	self.viewClosedCallback = aSelector;
}

- (IBAction)btnDoneClicked:(id)sender
{
	self.card.flipSide = self.textEdit.text;
	[self.target performSelector:self.viewClosedCallback];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnCancelClicked:(id)sender
{
	[self.target performSelector:self.viewClosedCallback];
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Memory Management

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.textEdit = nil;
}

- (void)dealloc
{
	[textEdit release];
    [super dealloc];
}


@end
