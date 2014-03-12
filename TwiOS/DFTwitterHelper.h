//
//  DFTwitterHelper.h
//  TwiOS
//
//  Created by Diego Freniche Brito on 29/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

/*
 
 MIT - Licence
 
 Copyright (c) 2014 Diego Freniche
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */


#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#import "DFTwitterAccountInfo.h"
#import "DFTweet.h"
#import "DFDirectMessage.h"

#define kDFTWITTER_HELPER_DOMAIN @"DFTwitterHelper"

typedef enum {
    DFTH_NO_ACCESS_GRANTED = 0,
    DFTH_NO_ACCOUNTS_SETUP,
    DFTH_RATE_LIMIT_REACHED,
    DFTH_OTHER_ERROR_CODE
} DFTwitterHelperErrorCodes;

@interface DFTwitterHelper : NSObject

/**
 @param [param] [Description]
 @return [Description]
 @see [selector]
 @warning [description]
 */
+ (void)twitterAccountInfoWithUser:(NSString *)twitterUser completion:(void(^)(DFTwitterAccountInfo *, NSError *))completion;
+ (void)tweetsWithCompletion:(void(^)(NSArray *, NSError *))completion;
+ (void)mentionsWithCompletion:(void(^)(NSArray *, NSError *))completion;
+ (void)directMessagesWithCompletion:(void(^)(NSArray *, NSError *))completion;

@end
