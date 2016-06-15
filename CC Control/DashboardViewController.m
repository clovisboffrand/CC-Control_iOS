//
//  DashboardViewController.m
//  CC Control
//
//  Created by admin_user on 6/15/16.
//  Copyright © 2016 WorldStar. All rights reserved.
//

#import "DashboardViewController.h"
#import "Constants.h"

@interface DashboardViewController () <UIWebViewDelegate>

@end

@implementation DashboardViewController
{
    IBOutlet UIWebView *mWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebViewContent];
}

- (void)loadWebViewContent {
    // WebView Settings
    mWebView.scrollView.scrollEnabled = NO;
    mWebView.scrollView.bounces = NO;
    mWebView.scalesPageToFit = NO;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:WEB_URL]];
    [mWebView loadRequest:request];
}

@end
