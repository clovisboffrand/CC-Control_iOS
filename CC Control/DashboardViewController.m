//
//  DashboardViewController.m
//  CC Control
//
//  Created by admin_user on 6/15/16.
//  Copyright © 2016 WorldStar. All rights reserved.
//

#import "DashboardViewController.h"
#import "Reachability.h"
#import "Constants.h"

@interface DashboardViewController () <UIWebViewDelegate>

@end

@implementation DashboardViewController
{
    IBOutlet UIWebView *mWebView;
    
    BOOL isVisibleErrorPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // WebView Settings
    mWebView.scrollView.scrollEnabled = NO;
    mWebView.scrollView.bounces = NO;
    mWebView.scalesPageToFit = NO;
    
    // Initialize Reachability
    Reachability *reachability = [Reachability reachabilityWithHostName:REACHABLE_TEST];
    
    // Start Monitoring
    [reachability startNotifier];
    
    // Add observer for reachability change.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES; // Should hide system notification bar.
}

#pragma mark - Load WebView Content

- (void)loadWebViewContent {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:WEB_URL]];
    [mWebView loadRequest:request];
}

#pragma mark - Reachability Observer

- (void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    
    if ([reachability isReachable]) {
        NSLog(@"Reachable");
        [self dismissErrorPage];
        [self loadWebViewContent];
    } else {
        NSLog(@"Unreachable");
        [self presentErrorPage];
    }
}

#pragma mark - Present / Dismiss Error Page

- (void)presentErrorPage {
    if (!isVisibleErrorPage) {
        isVisibleErrorPage = YES;
        UIViewController *errorViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ErrorViewController"];
        [self presentViewController:errorViewController animated:YES completion:nil];
    }
}

- (void)dismissErrorPage {
    if (isVisibleErrorPage) {
        [self dismissViewControllerAnimated:YES completion:^{
            isVisibleErrorPage = NO;
        }];
    }
}

@end
