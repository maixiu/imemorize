//
//  iMemorizeAppDelegate.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 18/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "iMemorizeAppDelegate.h"
#import "SummaryTableViewController.h"
#import "JmemorizeCsvFileParser.h";


@implementation iMemorizeAppDelegate

@synthesize window, cardsNavigation, mainTabBarController, learnSettings, cards;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSString *cardsFilePath = [self cardsDataFilePath];
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

	// Création et initialisation du view controller des listes de cartes
	SummaryTableViewController *summaryTable = [[SummaryTableViewController alloc] init];
	summaryTable.cards = cards;
	
	// Initialization du view controller "LearnSettings"
	self.learnSettings.cards = cards;
	
	[self.cardsNavigation pushViewController:summaryTable animated:NO];
	[window addSubview:mainTabBarController.view];
    [window makeKeyAndVisible];
   
	[summaryTable release];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	NSData *cardsData = [NSKeyedArchiver archivedDataWithRootObject:self.cards];
	[cardsData writeToFile:[self cardsDataFilePath] atomically:YES];
}

- (NSString *)cardsDataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	return [documentDirectory stringByAppendingPathComponent:@"iMemorize"];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [window release];
    [super dealloc];
}


@end
