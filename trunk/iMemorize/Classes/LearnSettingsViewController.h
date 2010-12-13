//
//  LearnSettingsViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 03/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardSet.h"
#import "LearnViewController.h"

@interface LearnSettingsViewController : UIViewController <LearnViewDelegate> {
	UILabel *lblNbCardsToLearn;
	UISegmentedControl *scCardsToLearn;
	CardSet *set;
}

@property (nonatomic, retain) IBOutlet UILabel *lblNbCardsToLearn;
@property (nonatomic, retain) IBOutlet UISegmentedControl *scCardsToLearn;
@property (nonatomic, retain) CardSet *set;

- (IBAction)nbCardsToLearnValueChanged:(id)sender;
- (IBAction)startTouchUpInside:(id)sender;

@end
