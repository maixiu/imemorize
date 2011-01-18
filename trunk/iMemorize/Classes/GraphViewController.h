//
//  GraphViewController.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 12/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "CardSet.h"

@interface GraphViewController : UIViewController <CardSetDelegate> {
	GraphView *graphView;
	CardSet *set;
}

@property (nonatomic, retain) CardSet *set;
@property (nonatomic, retain) GraphView *graphView;

@end
