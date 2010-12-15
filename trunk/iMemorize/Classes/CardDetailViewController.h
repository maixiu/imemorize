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
	UILabel *lblDeck;
	UILabel *lblExpired;
}

@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) IBOutlet UILabel *frontSide;
@property (nonatomic, retain) IBOutlet UITextView *flipSide;
@property (nonatomic, retain) IBOutlet UILabel *lblDeck;
@property (nonatomic, retain) IBOutlet UILabel *lblExpired;

@end
