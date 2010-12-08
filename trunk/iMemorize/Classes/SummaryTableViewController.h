//
//  SummaryTableViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 28/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SummaryTableViewController : UITableViewController
{
	NSArray *cards;
	NSArray *decks;
	NSArray *notLearnedCards;
	NSArray *decksAreExpired;
}

@property (nonatomic, retain) NSArray *cards;

@end
