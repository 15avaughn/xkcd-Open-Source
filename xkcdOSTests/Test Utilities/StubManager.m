//
//  StubManager.m
//  xkcd Open Source
//
//  Created by Mike on 5/22/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "StubManager.h"
#import <OHHTTPStubs/HTTPStubs.h>
#import <OHHTTPStubs/HTTPStubsResponse+JSON.h>

@implementation StubManager

+ (instancetype)sharedInstance {
    static StubManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (void)stubResponseWithStatusCode:(int)statusCode object:(id)object delay:(NSTimeInterval)delay {
    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString hasPrefix:@"http://xkcdos.app.sgnl24.com/"];
    } withStubResponse:^HTTPStubsResponse *(NSURLRequest *request) {
        return [[HTTPStubsResponse responseWithJSONObject:object ?: @{} statusCode:statusCode headers:nil] responseTime:delay];
    }];
}

- (void)removeAllStubs {
    [HTTPStubs removeAllStubs];
}

@end
