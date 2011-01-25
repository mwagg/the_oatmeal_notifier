//
//  the_oateal_notifierAppDelegate.h
//  the_oateal_notifier
//
//  Created by Michael on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ApplicationController.h"

@interface the_oateal_notifierAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	ApplicationController *appController;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet ApplicationController *appController;

@end
