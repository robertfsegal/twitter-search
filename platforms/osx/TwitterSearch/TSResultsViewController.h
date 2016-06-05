//
//  TSResultsViewController.h
//  TwitterSearch
//
//  Created by Robert Segal on 2016-06-04.
//  Copyright © 2016 __CDV_ORGANIZATION_NAME__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface TSResultsViewController : NSViewController
@property (weak) IBOutlet WebView *webView;

@end
