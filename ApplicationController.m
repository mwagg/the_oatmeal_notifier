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

- (id)init {
	if (self = [super init]) {
		NSURL *feedUrl = [NSURL URLWithString:theOatmealNewsFeedUrl];
		newsFeed = [[PSFeed alloc] initWithURL:feedUrl];
		rssQueue = [[NSOperationQueue alloc] init];
		[rssQueue setName:@"com.TheOatmealFeedViewer.rssQueu"];
		feedError = nil;
		psNotification = nil;
	}
	
	return self;
}

- (IBAction) startFeedRefresh:(id)sender {
	[newsFeed refresh:&feedError];
}

-(void)awakeFromNib {
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
														
													}];
												}];
}

@end
