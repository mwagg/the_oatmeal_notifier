//
//  the_oateal_notifierAppDelegate.m
//  the_oateal_notifier
//
//  Created by Michael on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "the_oateal_notifierAppDelegate.h"

@implementation the_oateal_notifierAppDelegate

@synthesize window;
@synthesize appController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[appController startFeedRefresh:self];
}

@end
