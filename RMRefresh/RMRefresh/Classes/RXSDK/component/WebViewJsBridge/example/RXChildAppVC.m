//
//  EPChildAppVC.m
//  EPIMApp
//
//  Created by Ryan on 15/10/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "RXChildAppVC.h"
#import "RXJsBridge.h"

#import <AVFoundation/AVFoundation.h>

@interface RXChildAppVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) RXJsBridge *bridge;

@end

@implementation RXChildAppVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置oc和js的桥接
    _bridge = [RXJsBridge bridgeForWebView:self.webView webViewDelegate:self];
    
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.delegate = self;
        _webView.frame = self.view.bounds;
    }
    return _webView;
}
@end
