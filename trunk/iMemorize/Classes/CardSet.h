//
//  CardSet.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 20/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

#define kCodingCardsKey			@"cards"
#define kCodingDecksKey			@"decks"
#define kCodingCardsNotLearned	@"cardsNotLearned"

@protocol CardSetDelegate
- (void)cardsUpdated:(id)sender;
@end

@interface CardSet : NSObject <NSCoding>
{
	NSArray *cards;
	NSArray *decks;
	NSArray *cardsNotLearned;
	BOOL isExpired;
	NSMutableArray *delegates;
}

+ (NSString *)cardsDataFilePath;
+ (id)cardSetFromArchiveOrElseFromResource;
- (void)archive;
- (NSArray *)getCardsToLearn:(int)nbCardsToLearn thatAreKnown:(BOOL)isKnown;
- (void)registerDelegate:(id <CardSetDelegate>)delegate;
- (void)updateCards:(NSArray *)updatedCards;

@property (nonatomic, retain) NSArray *cards;
@property (nonatomic, retain) NSArray *decks;
@property (nonatomic, retain) NSArray *cardsNotLearned;
@property (nonatomic, readonly) BOOL isExpired;

@end
