//
//  TwiOSTests.m
//  TwiOSTests
//
//  Created by Diego Freniche Brito on 27/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DFTwitterHelper.h"

@interface TwiOSTests : XCTestCase

@end

@implementation TwiOSTests


- (void)testCreateDFTwitterAccountUsingTwitterHelper
{
    __block BOOL wait = YES;
    
    [DFTwitterHelper twitterAccountInfoWithUser:@"dfrenichetester" completion:^(DFTwitterAccountInfo *account){
        NSLog(@"Printing in BLOCK");
        NSLog(@"%@", [account name]);
        XCTAssertNotNil(account, @"");
        XCTAssertEqualObjects(account.name, @"dfrenichetester", @"");
        wait = NO;

    }];
    
    while (wait) {
        
    }
}

- (void)testReadTimeline {
    __block BOOL wait = YES;

    [DFTwitterHelper readTweetsWithCompletion:^(NSArray *tweets) {
        XCTAssertNotNil(tweets, @"");
        NSLog(@"Number of tweets: %d", [tweets count]);
        
        
        wait = NO;
    }];
    
    while (wait) {
        
    }
}

@end
