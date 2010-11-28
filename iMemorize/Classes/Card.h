//
//  Card.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject
{
	NSString *frontSide;
	NSString *flipSide;
}

+ (id)cardWithFrontSide:(NSString *)front flipSide:(NSString *)flip;

@property (copy) NSString *frontSide;
@property (copy) NSString *flipSide;

@end
