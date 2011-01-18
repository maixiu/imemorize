//
//  GraphSection.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 13/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GraphSection : NSObject {
	UIColor *color;
	int size;
}

@property (nonatomic, copy) UIColor *color;
@property (nonatomic) int size;

- (id)initWithColor:(UIColor *)initColor size:(int)initSize;

@end
