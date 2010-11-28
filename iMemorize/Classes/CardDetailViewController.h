//
//  CardDetailViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 22/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface CardDetailViewController : UIViewController
{
	Card *card;
	UILabel *frontSide;
	UITextView *flipSide;
}

@property (retain) Card *card;
@property (retain) IBOutlet UILabel *frontSide;
@property (retain) IBOutlet UITextView *flipSide;

@end
