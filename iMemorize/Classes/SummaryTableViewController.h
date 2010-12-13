//
//  SummaryTableViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 28/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardSet.h"


@interface SummaryTableViewController : UITableViewController <CardSetDelegate>
{
	CardSet *set;
}

@property (nonatomic, retain) CardSet *set;

@end
