//
//  TSResultsViewController.m
//  TwitterSearch
//
//  Created by Robert Segal on 2016-06-04.
//  Copyright © 2016 __CDV_ORGANIZATION_NAME__. All rights reserved.
//

#import "TSResultsViewController.h"

@interface TSResultsViewController ()

@end

@implementation TSResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSURL        *path    = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:@"" subdirectory:@"www"];
    NSURLRequest *request = [NSURLRequest requestWithURL:path];
    
    [_webView.mainFrame loadRequest:request];
}

@end
