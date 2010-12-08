//
//  LearnViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 04/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LearnViewController : UIViewController {
	NSArray *cards;
	int currentCardIndex;
	int totalCardsCount;
	UIProgressView *progressView;
	UILabel *lblProgress;
	UILabel *lblFront;
	UITextView *txtFlip;
	UIButton *btnCancel;
	UIButton *btnAnswer;
	UIButton *btnYes;
	UIButton *btnNo;
	UIButton *btnClose;
}

@property (nonatomic, retain) NSArray *cards;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;
@property (nonatomic, retain) IBOutlet UILabel *lblProgress;
@property (nonatomic, retain) IBOutlet UILabel *lblFront;
@property (nonatomic, retain) IBOutlet UITextView *txtFlip;
@property (nonatomic, retain) IBOutlet UIButton *btnCancel;
@property (nonatomic, retain) IBOutlet UIButton *btnAnswer;
@property (nonatomic, retain) IBOutlet UIButton *btnYes;
@property (nonatomic, retain) IBOutlet UIButton *btnNo;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;

- (IBAction)btnCancelTouchUpInside:(id)sender;
- (IBAction)btnAnswerTouchUpInside:(id)sender;
- (IBAction)btnYesTouchUpInside:(id)sender;
- (IBAction)btnNoTouchUpInside:(id)sender;
- (IBAction)btnCloseTouchUpInside:(id)sender;

@end
