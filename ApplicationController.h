//
//  ApplicationController.h
//  the_oateal_notifier
//
//  Created by Michael on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PubSub/PubSub.h>


@interface ApplicationController : NSObject {
	PSFeed *newsFeed;
	NSOperationQueue *rssQueue;
	NSError *feedError;
	id psNotification;
	NSStatusItem *statusBar;
	NSMenu *statusMenu;
}

@property(retain) IBOutlet NSMenu *statusMenu;
@property(retain) NSOperationQueue *rssQueue;
@property(retain) PSFeed *newsFeed;
@property(retain) NSError *feedError;
@property(retain) id psNotification;

- (IBAction) startFeedRefresh:(id)sender;

@end
