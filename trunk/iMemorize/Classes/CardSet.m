//
//  CardSet.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 20/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "CardSet.h"
#import "Constants.h"
#import "JmemorizeCsvFileParser.h"
#import "Deck.h"


@interface CardSet()
@property (nonatomic, retain) NSMutableArray *delegates;
- (void)initDecks;
@end

@implementation CardSet

@synthesize cards, decks, cardsNotLearned, isExpired;
@synthesize delegates;

- (BOOL)isExpired
{
	for (Deck *deck in self.decks) {
		if (deck.isExpired) {
			return YES;
		}
	}
	
	return NO;
}

- (id)init
{
	if (self = [super init]) {
		self.delegates = [NSMutableArray arrayWithCapacity:5];
	}
	
	return self;
}


#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.cards forKey:kCodingCardsKey];
	[aCoder encodeObject:self.decks forKey:kCodingDecksKey];
	[aCoder encodeObject:self.cardsNotLearned forKey:kCodingCardsNotLearned];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [self init]) {
		self.cards = [aDecoder decodeObjectForKey:kCodingCardsKey];
		self.decks = [aDecoder decodeObjectForKey:kCodingDecksKey];
		self.cardsNotLearned = [aDecoder decodeObjectForKey:kCodingCardsNotLearned];
		self.delegates = [NSMutableArray arrayWithCapacity:5];
	}
	
	return self;
}


#pragma mark -
#pragma mark Methods

+ (id)cardSetFromArchiveOrElseFromResource
{
	CardSet *newCardSet;
	if (!(newCardSet = [NSKeyedUnarchiver unarchiveObjectWithFile:[CardSet cardsDataFilePath]])) {
		// Chargement des cartes à partir du fichier en resources
		newCardSet = [[[CardSet alloc] init] autorelease];
		NSString *filePath = [[NSBundle mainBundle] pathForResource:kResourceJmemorizeFileName ofType:kResourceJmemorizeFileType];
		NSString *dataFile = [NSString stringWithContentsOfFile:filePath
													   encoding:NSUTF8StringEncoding
														  error:NULL];
		newCardSet.cards = [JmemorizeCsvFileParser parseCardsFromData:dataFile];
		[newCardSet initDecks];
	}
	
	return newCardSet;
}

+ (NSString *)cardsDataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	return [documentDirectory stringByAppendingPathComponent:kArchiveFileName];	
}

- (void)archive
{
	NSData *cardsData = [NSKeyedArchiver archivedDataWithRootObject:self];
	[cardsData writeToFile:[CardSet cardsDataFilePath] atomically:YES];
}

- (void)initDecks
{
	NSMutableArray *newDecks = [NSMutableArray arrayWithCapacity:kMaxDeckCount];
	NSMutableArray *tmpDecks = [[NSMutableArray alloc] initWithCapacity:kMaxDeckCount];
	NSMutableArray *newCardsNotLearned = [NSMutableArray arrayWithCapacity:self.cards.count];
	for (Card *card in self.cards) {
		if (card.deck > 0) {
			// The card is in a deck
			int deckNum = card.deck <= kMaxDeckCount ? card.deck : kMaxDeckCount;
			if (deckNum > newDecks.count) {
				// Initialize decks length
				for (int i = newDecks.count; i < deckNum; i++) {
					NSMutableArray *cardsInDeck = [NSMutableArray arrayWithCapacity:self.cards.count];
					Deck *newDeck = [Deck deckWithPosition:i];
					newDeck.cards = cardsInDeck;
					[tmpDecks insertObject:cardsInDeck atIndex:i];
					[newDecks insertObject:newDeck atIndex:i];
				}
			}
			
			NSMutableArray *cardsInDeck = [tmpDecks objectAtIndex:deckNum - 1];
			[cardsInDeck addObject:card];
		}
		else {
			// The card haven't been learned yet.
			[newCardsNotLearned addObject:card];
		}
	}
		
	self.decks = newDecks;
	self.cardsNotLearned = newCardsNotLearned;
	[tmpDecks release];
}

- (NSArray *)getCardsToLearn:(int)nbCardsToLearn thatAreKnown:(BOOL)isKnown
{
	NSMutableArray *cardsToLearn = [NSMutableArray arrayWithCapacity:self.cards.count];
	
	for (Card *card in self.cards) {
		BOOL cardIsExpired = [card.expired compare:[NSDate dateWithTimeIntervalSinceNow:0]] == NSOrderedAscending;
		//Si unlearned est sélectionné || si expired est sélectionné
		if ((!isKnown && card.deck == 0) || (isKnown && cardIsExpired))
		{
			[cardsToLearn addObject:card];
			if (cardsToLearn.count == nbCardsToLearn) {
				break;
			}
		}
	}
	
	return cardsToLearn;
}

- (void)registerDelegate:(id <CardSetDelegate>)delegate
{
	[self.delegates addObject:delegate];
}

- (void)updateCards:(NSArray *)updatedCards
{
	//Remettre les cartes mises à jour dans les bons decks.
	[self initDecks];
	
	for (id <CardSetDelegate> delegate in self.delegates) {
		[delegate cardsUpdated:self];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[cards release];
	[super dealloc];
}

@end
