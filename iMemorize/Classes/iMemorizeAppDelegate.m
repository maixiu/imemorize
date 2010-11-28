//
//  iMemorizeAppDelegate.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 18/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "iMemorizeAppDelegate.h"
#import "CardsTableViewController.h"


@implementation iMemorizeAppDelegate

@synthesize window, navigation;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
	// Chargement des cartes
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jmemorize" ofType:@"csv"];
	CardSet *set = [[CardSet alloc] initWithFile:filePath];
	
	navigation = [[UINavigationController alloc] init];
	CardsTableViewController *cardsTable = [[CardsTableViewController alloc] initWithNibName:@"CardsTable" bundle:nil];
	cardsTable.set = set;
	
	[self.navigation pushViewController:cardsTable animated:NO];
	[window addSubview:navigation.view];
    [window makeKeyAndVisible];
   
	[cardsTable release];
	[set release];
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [window release];
	[navigation release];
    [super dealloc];
}


@end
