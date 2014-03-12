//
//  TwiOSTests.m
//  TwiOSTests
//
//  Created by Diego Freniche Brito on 27/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DFTwitterHelper.h"

@interface DFTwitterHelperTests : XCTestCase

@end

@implementation DFTwitterHelperTests


- (void)testCreateDFTwitterAccountUsingTwitterHelper
{
    __block BOOL wait = YES;
    [DFTwitterHelper twitterAccountInfoWithUser:@"dfrenichetester" completion:^(DFTwitterAccountInfo *account, NSError *error){
        XCTAssertNil(error, @"Error %d", error.code);
        
        XCTAssertNotNil(account, @"");
        XCTAssertEqualObjects(account.name, @"dfrenichetester", @"%@", [account name]);
        wait = NO;
    }];
    
    while (wait) {
        NSLog(@"...");
        sleep(1);
    }
}

- (void)testReadTimeline {
    __block BOOL wait = YES;

    [DFTwitterHelper tweetsWithCompletion:^(NSArray *tweets, NSError *error) {
        XCTAssertNil(error, @"Error %d", error.code);

        XCTAssertNotNil(tweets, @"");
        NSLog(@"Number of tweets: %d", [tweets count]);
        
        
        wait = NO;
    }];
    
    while (wait) {
        
    }
}


- (void)testReadMentions {
    __block BOOL wait = YES;
    
    [DFTwitterHelper mentionsWithCompletion:^(NSArray *tweets, NSError *error) {
        XCTAssertNil(error, @"Error %d", error.code);
        
        XCTAssertNotNil(tweets, @"");
        NSLog(@"Number of tweets: %d", [tweets count]);
        
        
        wait = NO;
    }];
    
    while (wait) {
        
    }
}

- (void)testReadDMs {
    __block BOOL wait = YES;
    
    [DFTwitterHelper directMessagesWithCompletion:^(NSArray *tweets, NSError *error) {
        XCTAssertNil(error, @"Error %d", error.code);
        
        XCTAssertNotNil(tweets, @"");
        NSLog(@"Number of tweets: %d", [tweets count]);
        
        
        wait = NO;
    }];
    
    while (wait) {
        
    }
}

@end
