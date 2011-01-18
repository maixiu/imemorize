//
//  GraphView.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 12/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphView : UIView {
	NSMutableArray *bars;
}

- (void)reinitData;
- (void)addBarWithIndex:(int)index section:(int)section color:(UIColor *)color size:(int)size;

@end
