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


@implementation CardSet

@synthesize cards;

- (void)loadCardSetFromPersistance
{
	NSString *cardsFilePath = [CardSet cardsDataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:cardsFilePath]) {
		// Chargement des cartes à partir du fichier archivé
		NSData *cardsData = [NSData dataWithContentsOfFile:cardsFilePath];
		cards = [NSKeyedUnarchiver unarchiveObjectWithData:cardsData];
	}
	else {
		// Chargement des cartes à partir du fichier en resources
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jmemorize" ofType:@"csv"];
		NSString *dataFile = [NSString stringWithContentsOfFile:filePath
													   encoding:NSUTF8StringEncoding
														  error:NULL];
		cards = [[JmemorizeCsvFileParser parseCardsFromData:dataFile] retain];
	}
}

+ (NSString *)cardsDataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	return [documentDirectory stringByAppendingPathComponent:kArchiveFileName];	
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[cards release];
	[super dealloc];
}

@end
