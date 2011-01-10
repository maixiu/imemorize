//
//  CardsTableViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardsTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, CardDelegate>
{
	NSArray *cards;
	NSArray *sections;
	NSDictionary *pagedCardSet;
	NSArray *searchCards;
}

@property (nonatomic, retain) NSArray *cards;

@end
