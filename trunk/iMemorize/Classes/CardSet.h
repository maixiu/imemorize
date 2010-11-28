//
//  CardSet.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 20/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface CardSet : NSObject
{
	NSArray *cards;
}

- (id)initWithFile:(NSString *)path;
- (void)loadCardsFromFile:(NSString *)path;

@property (readonly) NSArray *cards;

@end
