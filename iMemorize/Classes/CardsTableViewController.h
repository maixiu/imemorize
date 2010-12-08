//
//  CardsTableViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CardsTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
{
	NSArray *cards;
	NSArray *sections;
	NSDictionary *pagedCardSet;
	NSArray *searchCards;
}

@property (nonatomic, retain) NSArray *cards;

@end
