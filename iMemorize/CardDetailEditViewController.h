//
//  CardDetailEditViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 06/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@interface CardDetailEditViewController : UIViewController {
	Card *card;
	UITextView *textEdit;
	id target;
	SEL viewClosedCallback;
}

@property (nonatomic, retain) IBOutlet UITextView *textEdit;
@property (nonatomic, retain) Card *card;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL viewClosedCallback;

- (IBAction)btnDoneClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
- (void)setViewClosedCallbackWithTarget:(id)aTarget andSelector:(SEL)aSelector;

@end
