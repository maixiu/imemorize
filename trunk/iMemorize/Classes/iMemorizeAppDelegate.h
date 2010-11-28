//
//  iMemorizeAppDelegate.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 18/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iMemorizeAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
	UINavigationController *navigation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (retain) UINavigationController *navigation;

@end

