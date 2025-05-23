//
//  NewSubscription.m
//  Vienna
//
//  Created by Steve on 4/23/05.
//  Copyright (c) 2004-2005 Steve Palmer. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NewSubscription.h"
#import "AppController.h"
#import "StringExtensions.h"
#import "Preferences.h"
#import "SubscriptionModel.h"
#import "PluginManager.h"
#import "FeedSourcePlugin.h"
#import "Folder.h"
#import "Database.h"

@interface NewSubscription ()

-(void)loadRSSFeedBundle;
-(void)setLinkTitle;
-(void)enableSaveButton;
-(void)enableSubscribeButton;

@end

@implementation NewSubscription {
    IBOutlet NSTextField *linkTitle;
    IBOutlet NSTextField *feedURL;
    IBOutlet NSTextField *editFeedURL;
    IBOutlet NSPopUpButton *feedSource;
    IBOutlet NSButton *subscribeButton;
    IBOutlet NSButton *saveButton;
    IBOutlet NSButton *editCancelButton;
    IBOutlet NSButton *subscribeCancelButton;
    IBOutlet NSWindow *newRSSFeedWindow;
    IBOutlet NSWindow *editRSSFeedWindow;
    IBOutlet NSButton *siteHomePageButton;
    BOOL googleOptionButton;
    NSDictionary *sourcesDict;
    Database *db;
    NSInteger editFolderId;
    SubscriptionModel *subscriptionModel;
    NSMenuItem *webPageMenuItem;
    NSMenuItem *localFileMenuItem;
}

/* initWithDatabase
 * Just init the RSS feed class.
 */
-(instancetype)initWithDatabase:(Database *)newDb
{
	if ((self = [super init]) != nil) {
		db = newDb;
		editFolderId = -1;
        subscriptionModel = [[SubscriptionModel alloc] init];
	}
	return self;
}

/* newSubscription
 * Display the sheet to create a new RSS subscription.
 */
-(void)newSubscription:(NSWindow *)window initialURL:(NSString *)initialURL
{
    [self loadRSSFeedBundle];

    [feedSource removeAllItems];

    NSString *webPageMenuItemTitle = NSLocalizedString(@"URL", @"Title of a menu item");
    webPageMenuItem = [[NSMenuItem alloc] initWithTitle:webPageMenuItemTitle
                                                 action:NULL
                                          keyEquivalent:@""];
    webPageMenuItem.representedObject = @{
        @"LinkName": NSLocalizedString(@"Enter URL of RSS feed",
                                       @"An instruction that will be shown above a text field."),
        @"LinkTemplate": @"%@",
    };
    [feedSource.menu addItem:webPageMenuItem];

    NSString *localFileMenuItemTitle = NSLocalizedString(@"Local file", @"Title of a menu item");
    localFileMenuItem = [[NSMenuItem alloc] initWithTitle:localFileMenuItemTitle
                                                   action:NULL
                                            keyEquivalent:@""];
    localFileMenuItem.representedObject = @{
        @"LinkName": NSLocalizedString(@"Enter the path under your home folder",
                                       @"An instruction that will be shown above a text field."),
        // LinkTemplate is not required.
    };
    [feedSource.menu addItem:localFileMenuItem];

    NSArray<VNAPlugin *> *plugins = [self.pluginManager pluginsOfType:[VNAFeedSourcePlugin class]];
    if (plugins.count > 0) {
        [feedSource.menu addItem:[NSMenuItem separatorItem]];
        for (VNAPlugin *plugin in plugins) {
            NSMenuItem *feedMenuItem = [[NSMenuItem alloc] initWithTitle:plugin.displayName
                                                                  action:NULL
                                                           keyEquivalent:@""];
            feedMenuItem.representedObject = plugin;
            [feedSource.menu addItem:feedMenuItem];
        }
    }
    [feedSource selectItem:webPageMenuItem];

    // Look on the pasteboard to see if there's an http:// url and, if so, prime the
    // URL field with it. A handy shortcut.
    NSString *candidateURL = initialURL.vna_trimmed;
    BOOL fromClipboard = NO;
    if (candidateURL == nil) {
        NSData *pboardData = [[NSPasteboard generalPasteboard] dataForType:NSPasteboardTypeString];
        if (pboardData != nil) {
            NSString *pasteString = [[NSString alloc] initWithData:pboardData encoding:NSASCIIStringEncoding].vna_trimmed;
            NSString *lowerCasePasteString = pasteString.lowercaseString;

            if (lowerCasePasteString != nil &&
                ([lowerCasePasteString hasPrefix:@"http://"] || [lowerCasePasteString hasPrefix:@"https://"] ||
                 [lowerCasePasteString hasPrefix:@"feed://"]))
            {
                candidateURL = pasteString;
                fromClipboard = YES;
            }
        }
    }
    // Work around (wrong) duplicate schemes
    NSString *lowercaseURL = [candidateURL lowercaseString];
    if ([lowercaseURL hasPrefix:@"feed:http://"] || [lowercaseURL hasPrefix:@"feed:https://"]) {
        candidateURL = [candidateURL substringFromIndex:[@"feed:" length]];
    }
    // populate the sheet's text field for URL
    if (candidateURL != nil) {
        feedURL.stringValue = candidateURL;
    } else {
        feedURL.stringValue = @"";
    }
    if (fromClipboard) {
        [feedURL selectText:self];
    }

    // Reset from the last time we used this sheet.
    [self enableSubscribeButton];
    [self setLinkTitle];
    editFolderId = -1;
    [newRSSFeedWindow makeFirstResponder:feedURL];
    //restore from preferences, if it can be done ; otherwise, uncheck this option
    self.googleOptionButton = [Preferences standardPreferences].syncGoogleReader
                              && [Preferences standardPreferences].prefersGoogleNewSubscription;
    [window beginSheet:newRSSFeedWindow completionHandler:nil];
} // newSubscription

/* editSubscription
 * Edit an existing RSS subscription.
 */
-(void)editSubscription:(NSWindow *)window folderId:(NSInteger)folderId
{
	[self loadRSSFeedBundle];

	Folder * folder = [db folderFromID:folderId];
	if (folder != nil) {
		editFeedURL.stringValue = folder.feedURL;
		[self enableSaveButton];
		editFolderId = folderId;
		
		// Open the edit sheet.
        [window beginSheet:editRSSFeedWindow completionHandler:nil];
	}
}

/* loadRSSFeedBundle
 * Load the RSS feed bundle if not already.
 */
-(void)loadRSSFeedBundle
{
	if (!editRSSFeedWindow || !newRSSFeedWindow) {
		NSArray * objects;
		[[NSBundle bundleForClass:[self class]] loadNibNamed:@"RSSFeed" owner:self topLevelObjects:&objects];
		self.topObjects = objects;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextDidChange:) name:NSControlTextDidChangeNotification object:feedURL];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextDidChange2:) name:NSControlTextDidChangeNotification object:editFeedURL];
	}
}

/* doSubscribe
 * Handle the URL subscription button.
 */
-(IBAction)doSubscribe:(id)sender
{
	NSURL * rssFeedURL;
	NSString * feedURLString = (feedURL.stringValue).vna_trimmed;
	// Replace feed:// with http:// if necessary
	if ([feedURLString hasPrefix:@"feed://"]) {
		feedURLString = [NSString stringWithFormat:@"http://%@", [feedURLString substringFromIndex:7]];
	}

	// Format the URL based on the selected feed source.
    if ([feedSource.selectedItem.representedObject isKindOfClass:[NSDictionary class]]) {
        if ([feedSource.selectedItem isEqual:localFileMenuItem]) {
            rssFeedURL = [NSURL fileURLWithPath:feedURLString.stringByExpandingTildeInPath];
        } else if ([feedSource.selectedItem isEqual:webPageMenuItem]) {
            NSDictionary<NSString *, NSString *> *dict = feedSource.selectedItem.representedObject;
            NSString *linkTemplate = dict[@"LinkTemplate"];
            NSString *urlString = [NSString stringWithFormat:linkTemplate, feedURLString];
            rssFeedURL = [NSURL URLWithString:urlString];
        }
    } else if ([feedSource.selectedItem.representedObject isKindOfClass:[VNAFeedSourcePlugin class]]) {
        VNAFeedSourcePlugin *plugin = feedSource.selectedItem.representedObject;
        NSString *linkTemplate = plugin.queryString;
        if (linkTemplate.length > 0) {
            rssFeedURL = [NSURL URLWithString:[NSString stringWithFormat:linkTemplate, feedURLString]];
        }
    }

	// Validate the subscription, possibly replacing the feedURLString with a real one if
	// it originally pointed to a web page.
	rssFeedURL = [subscriptionModel verifiedFeedURLFromURL:rssFeedURL];
	NSAssert(rssFeedURL != nil, @"No valid URL verified to attempt subscription !");

 	// Check if we have already subscribed to this feed by seeing if a folder exists in the db
	if ([db folderFromFeedURL:rssFeedURL.absoluteString] != nil) {
        NSAlert *alert = [NSAlert new];
        alert.messageText = NSLocalizedString(@"Error", @"Already subscribed title");
        alert.informativeText = NSLocalizedString(@"You are already subscribed to that feed", @"You are already subscribed to that feed");
        [alert runModal];
	}

    // call the controller to create the new subscription
    // or select the existing one if it already exists
	[APPCONTROLLER createSubscriptionInCurrentLocationForUrl:rssFeedURL];
    
	// Close the window
	[newRSSFeedWindow.sheetParent endSheet:newRSSFeedWindow];
	[newRSSFeedWindow orderOut:self];
}

/* doSave
 * Save changes to the RSS feed information.
 */
-(IBAction)doSave:(id)sender
{
	NSString * feedURLString = editFeedURL.stringValue.vna_trimmed;

	// Save the new information to the database
    [[Database sharedManager] setFeedURL:feedURLString forFolder:editFolderId];
	
	// Close the window
	[editRSSFeedWindow.sheetParent endSheet:editRSSFeedWindow];
	[editRSSFeedWindow orderOut:self];
}

/* doSubscribeCancel
 * Handle the Cancel button.
 */
-(IBAction)doSubscribeCancel:(id)sender
{
	[newRSSFeedWindow.sheetParent endSheet:newRSSFeedWindow];
	[newRSSFeedWindow orderOut:self];
}

/* doEditCancel
 * Handle the Cancel button.
 */
-(IBAction)doEditCancel:(id)sender
{
	[editRSSFeedWindow.sheetParent endSheet:editRSSFeedWindow];
	[editRSSFeedWindow orderOut:self];
}

/* doLinkSourceChanged
 * Called when the user changes the selection in the popup menu.
 */
-(IBAction)doLinkSourceChanged:(id)sender
{
	[self setLinkTitle];
}

@synthesize googleOptionButton;


/* doGoogleOption
 * Action called by the Open Reader checkbox
 * Memorizes the setting in preferences
*/
-(IBAction)doGoogleOption:(id)sender
{
    [Preferences standardPreferences].prefersGoogleNewSubscription = ([sender state] == NSControlStateValueOn);
}

/* handleTextDidChange [delegate]
 * This function is called when the contents of the input field is changed.
 * We disable the Subscribe button if the input fields are empty or enable it otherwise.
 */
-(void)handleTextDidChange:(NSNotification *)aNotification
{
	[self enableSubscribeButton];
}

/* handleTextDidChange2 [delegate]
 * This function is called when the contents of the input field is changed.
 * We disable the Save button if the input fields are empty or enable it otherwise.
 */
-(void)handleTextDidChange2:(NSNotification *)aNotification
{
	[self enableSaveButton];
}

/* setLinkTitle
 * Set the text of the label that prompts for the link based on the source
 * that the user selected from the popup menu.
 */
-(void)setLinkTitle
{
	NSMenuItem * feedSourceItem = feedSource.selectedItem;
	NSString * linkTitleString = nil;
	BOOL showButton = NO;
	if (feedSourceItem != nil) {
        if ([feedSourceItem.representedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, NSString *> *dict = feedSourceItem.representedObject;
            linkTitleString = dict[@"LinkName"];
            showButton = NO;
        } else if ([feedSourceItem.representedObject isKindOfClass:[VNAFeedSourcePlugin class]]) {
            VNAFeedSourcePlugin *plugin = feedSourceItem.representedObject;
            linkTitleString = plugin.hintLabel;
            showButton = plugin.homePageURL != nil;
        }
	}
	if (linkTitleString == nil) {
		linkTitleString = @"Link";
	}
	linkTitle.stringValue = [NSString stringWithFormat:@"%@:", linkTitleString];
	siteHomePageButton.hidden = !showButton;
}

/* doShowSiteHomePage
 */
-(void)doShowSiteHomePage:(id)sender
{
    if ([feedSource.selectedItem.representedObject isKindOfClass:[VNAFeedSourcePlugin class]]) {
        VNAFeedSourcePlugin *plugin = feedSource.selectedItem.representedObject;
        [NSWorkspace.sharedWorkspace openURL:plugin.homePageURL];
    }
}

/* enableSubscribeButton
 * Enable or disable the Subscribe button depending on whether or not there is a non-blank
 * string in the input fields.
 */
-(void)enableSubscribeButton
{
	NSString * feedURLString = feedURL.stringValue;
	subscribeButton.enabled = !feedURLString.vna_isBlank;
}

/* enableSaveButton
 * Enable or disable the Save button depending on whether or not there is a non-blank
 * string in the input fields.
 */
-(void)enableSaveButton
{
	NSString * feedURLString = editFeedURL.stringValue;
	saveButton.enabled = !feedURLString.vna_isBlank;
}

/* dealloc
 * Clean up and release resources.
 */
-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
