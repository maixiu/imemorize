//
//  GraphBar.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 13/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GraphBar : NSObject {
	NSMutableArray *sections;
}

@property (nonatomic, retain) NSMutableArray *sections;

- (void)addSectionWithIndex:(int)index color:(UIColor *)color size:(int)size;
- (int)totalSize;

@end
