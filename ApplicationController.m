//
//  ApplicationController.m
//  the_oateal_notifier
//
//  Created by Michael on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ApplicationController.h"

@implementation ApplicationController

static NSString *theOatmealNewsFeedUrl = @"http://theoatmeal.com/feed/rss";

@synthesize rssQueue;
@synthesize newsFeed;
@synthesize feedError;
@synthesize psNotification;
@synthesize statusMenu;

- (id)init {
	if (self = [super init]) {
		NSURL *feedUrl = [NSURL URLWithString:theOatmealNewsFeedUrl];
		newsFeed = [[PSFeed alloc] initWithURL:feedUrl];
		rssQueue = [[NSOperationQueue alloc] init];
		[rssQueue setName:@"com.TheOatmealFeedViewer.rssQueue"];
		feedError = nil;
		psNotification = nil;
	}
	
	return self;
}

- (IBAction) startFeedRefresh:(id)sender {
	[newsFeed refresh:&feedError];
}

-(void) setIsHighlighted:(BOOL)status {
	NSString *imageName;
	if (status == YES) {
		imageName = @"oatmeal_highlight.tif";
	} else {
		imageName = @"oatmeal_lolight.tif";
	}
		
	[statusBar setImage:[NSImage imageNamed:imageName]];
}

-(void)showStatusBar {
	statusBar = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusBar setHighlightMode:YES];
	[statusBar setMenu:statusMenu];
	[self setIsHighlighted:YES];
}

-(void) viewItem:(id)sender {
	PSEntry *entry = (PSEntry *)[sender representedObject];
	[[NSWorkspace sharedWorkspace] openURL:entry.alternateURL];
}

-(void) updateStatusMenu {
	[statusMenu removeAllItems];
	
	NSEnumerator *entriesEnumerator = [newsFeed.entries objectEnumerator];
	PSEntry *entry;
	while (entry = (PSEntry *)[entriesEnumerator nextObject]) {
		NSString *title = entry.titleForDisplay;
		NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:title action:@selector(viewItem:) keyEquivalent:@""];
		[menuItem setTarget:self];
		[menuItem setRepresentedObject:entry];
		[statusMenu addItem:menuItem];
	}
}

-(void) registerForNotifications {
	NSNotificationCenter *notifyCentre = [NSNotificationCenter defaultCenter];
	self.psNotification = [notifyCentre addObserverForName:PSFeedRefreshingNotification
													object:newsFeed
													 queue:rssQueue
												usingBlock:^(NSNotification *arg1) {
													if ([newsFeed isRefreshing]) {
														return;
													}
													
													[[NSOperationQueue mainQueue] addOperationWithBlock:^{

														if (nil != feedError) {
															[NSApp presentError:feedError];
															return;
														}	
														
														[self willChangeValueForKey:@"newsFeed"];
														[self didChangeValueForKey:@"newsFeed"];
														
														[self updateStatusMenu];
													}];
												}];
}

-(void)awakeFromNib {
	[self showStatusBar];
	[self registerForNotifications];
}

@end
