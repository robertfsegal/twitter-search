/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "AppDelegate.h"
#import "MainViewController.h"
#import "TSResultsViewController.h"

@implementation AppDelegate

@synthesize window;

NSButton     *button;
NSPopover    *popover;
NSStatusItem *statusItem;

- (id)init
{
    self = [super init];
    
    return self;
}

- (void) applicationDidStartLaunching:(NSNotification*) aNotification 
{
}

- (void) applicationWillFinishLaunching:(NSNotification*)aNotification
{
}

- (void) applicationDidFinishLaunching:(NSNotification*)aNotification 
{
    if (!popover)
    {
        popover = [[NSPopover alloc] init];
    }
    
    statusItem  = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    statusItem.action = @selector(togglePopover:);
    
    button = statusItem.button;
    
    if (button)
    {
        button.image = [NSImage imageNamed:@"youtube-search"];
        button.action = @selector(togglePopover:);
    }

    popover.contentViewController = [[TSResultsViewController alloc] initWithNibName:@"TSResultsViewController" bundle:nil];
}

-(void) showPopover:(id)sender
{
    if (button == statusItem.button)
    {
        [popover showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMinY];
    }
}

-(void)closePopover:(id)sender
{
    [popover performClose:sender];
}

-(void)togglePopover:(id)sender
{
    if (popover.shown)
    {
        [self closePopover:sender];
    }
    else
    {
        [self showPopover:sender];
    }
}

@end
