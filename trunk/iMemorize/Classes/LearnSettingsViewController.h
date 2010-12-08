//
//  LearnSettingsViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 03/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LearnSettingsViewController : UIViewController {
	UILabel *lblNbCardsToLearn;
	UISegmentedControl *scCardsToLearn;
	NSArray *cards;
}

@property (nonatomic, retain) IBOutlet UILabel *lblNbCardsToLearn;
@property (nonatomic, retain) IBOutlet UISegmentedControl *scCardsToLearn;
@property (nonatomic, retain) NSArray *cards;

- (IBAction)nbCardsToLearnValueChanged:(id)sender;
- (IBAction)startTouchUpInside:(id)sender;

@end
