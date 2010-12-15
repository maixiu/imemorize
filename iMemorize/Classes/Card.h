//
//  Card.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCodingDeckKey		@"deck"
#define kCodingExpiredKey	@"expired"
#define kCodingFrontSideKey	@"frontSide"
#define kCodingFlipSideKey	@"flipSide"

@interface Card : NSObject <NSCoding>
{
	int deck;
	NSDate *expired;
	NSString *frontSide;
	NSString *flipSide;
}

+ (id)cardWithFrontSide:(NSString *)front flipSide:(NSString *)flip deck:(int)newDeck;
- (void)reschedule;
- (BOOL)isExpired;

@property int deck;
@property (nonatomic, retain) NSDate *expired;
@property (nonatomic, copy) NSString *frontSide;
@property (nonatomic, copy) NSString *flipSide;

@end
