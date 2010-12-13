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
	BOOL isExpired;
	int position;
}

+ (id)deckWithPosition:(int)newPosition;

@property (nonatomic, retain) NSArray *cards;
@property (nonatomic, readonly) BOOL isExpired;
@property (nonatomic) int position;

@end
