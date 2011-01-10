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

@protocol CardDelegate
- (void)cardUpdated:(id)sender;
@end


@interface Card : NSObject <NSCoding>
{
	int deck;
	NSDate *expired;
	NSString *frontSide;
	NSString *flipSide;
	NSMutableArray *delegates;
}

+ (id)cardWithFrontSide:(NSString *)front flipSide:(NSString *)flip deck:(int)newDeck;
- (void)reschedule;
- (BOOL)isExpired;
- (void)registerDelegate:(id <CardDelegate>)delegate;
- (void)unSubscribeDelegate:(id <CardDelegate>)delegate;
- (void)setFlipSideAndNotify:(NSString *)newFlipSide;

@property int deck;
@property (nonatomic, retain) NSDate *expired;
@property (nonatomic, copy) NSString *frontSide;
@property (nonatomic, copy) NSString *flipSide;

@end
