//
//  iMemorizeAppDelegate.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 18/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearnSettingsViewController.h"
#import "GraphViewController.h"
#import "CardSet.h"

@interface iMemorizeAppDelegate : NSObject <UIApplicationDelegate, CardSetDelegate>
{
	UIWindow *window;
	UINavigationController *cardsNavigation;
	UITabBarController *mainTabBarController;
	LearnSettingsViewController *learnSettings;
	GraphViewController *graph;
	CardSet *set;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *cardsNavigation;
@property (nonatomic, retain) IBOutlet UITabBarController *mainTabBarController;
@property (nonatomic, retain) IBOutlet LearnSettingsViewController *learnSettings;
@property (nonatomic, retain) IBOutlet GraphViewController *graph;
@property (nonatomic, retain) CardSet *set;

@end

