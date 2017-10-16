//
//  APILoaderView.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/07/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "APILoaderView.h"

#define LOADER_TAG 20

@implementation APILoaderView
{
    UIActivityIndicatorView *indicator;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.frame = CGRectMake(10.0, 10.0, 60.0, 60.0);
        indicator.tintColor = [UIColor blackColor];
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-80)/2, (frame.size.height-80)/2, 80, 80)];
        grayView.layer.cornerRadius = 10.0;
        grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        indicator.color = [UIColor whiteColor];
        [grayView addSubview:indicator];
        [indicator bringSubviewToFront:grayView];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
        [indicator startAnimating];
        [self addSubview:grayView];
    }
    return self;
}

+(void)showLoaderInView:(UIView *)view
{
    APILoaderView *loader = [[self alloc] initWithFrame:view.bounds];
    loader.tag = LOADER_TAG;
    [view addSubview:loader];
}

+(void)hideLoaderInView:(UIView *)view
{
    APILoaderView *loader = [view viewWithTag:LOADER_TAG];
    if (loader) {
        [loader removeFromSuperview];
    }
}

@end
