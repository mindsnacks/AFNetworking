//
//  BasicTests.m
//  AFNetworking
//
//  Created by Andy Mroczkowski on 2/13/13.
//  Copyright (c) 2013 AFNetworking. All rights reserved.
//

#import "BasicTests.h"

#import <AFNetworking/AFNetworking.h>

#define DEFAULT_TIMEOUT_SECONDS 60

@implementation BasicTests

- (void)testSimpleHTTPGet
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://google.com"]];
    AFHTTPRequestOperation *requestOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [requestOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:_cmd];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        GHTestLog(@"Request failed: %@", error);
        [self notify:kGHUnitWaitStatusFailure forSelector:_cmd];
    }];
    
    [self prepare];
    [queue addOperation:requestOp];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:DEFAULT_TIMEOUT_SECONDS];
}

@end
