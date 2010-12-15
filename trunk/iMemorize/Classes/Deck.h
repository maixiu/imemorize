//
//  Deck.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 08/12/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCodingCardsKey		@"cards"
#define kCodingPosition		@"position"

@interface Deck : NSObject <NSCoding>
{
	NSArray *cards;
	int position;
}

+ (id)deckWithPosition:(int)newPosition;
- (BOOL)isExpired;

@property (nonatomic, retain) NSArray *cards;
@property (nonatomic) int position;

@end
