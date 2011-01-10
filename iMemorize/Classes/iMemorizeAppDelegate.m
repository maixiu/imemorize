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


@interface iMemorizeAppDelegate()
- (void)setUnlearnedCountOnTabBar;
@end


@implementation iMemorizeAppDelegate

@synthesize window, cardsNavigation, mainTabBarController, learnSettings, set;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.set = [CardSet cardSetFromArchiveOrElseFromResource];
	[self.set registerDelegate:self];
	
	// Création et initialisation du view controller des listes de cartes
	SummaryTableViewController *summaryTable = [[SummaryTableViewController alloc] init];
	summaryTable.set = self.set;
	[self.set registerDelegate:summaryTable];
	
	// Initialization du view controller "LearnSettings"
	self.learnSettings.set = self.set;
	
	[self.cardsNavigation pushViewController:summaryTable animated:NO];
	[window addSubview:mainTabBarController.view];
    [window makeKeyAndVisible];
   
	[self setUnlearnedCountOnTabBar];
	
	[summaryTable release];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[set archive];
	
	// Mise à jour du badge de l'application avec le nombre de cartes expirées
	[application setApplicationIconBadgeNumber:[self.set cardsExpiredCount]];
}


#pragma mark -
#pragma mark CardSetDelegate

- (void)cardsUpdated:(id)sender
{
	[self setUnlearnedCountOnTabBar];
}


#pragma mark -
#pragma mark Private Methods

- (void)setUnlearnedCountOnTabBar
{
	UITabBarItem *iMemorizeTab = [[self.mainTabBarController.tabBar items] objectAtIndex:0];
	iMemorizeTab.badgeValue = [NSString stringWithFormat:@"%d", [self.set cardsExpiredCount]];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [window release];
    [super dealloc];
}


@end
