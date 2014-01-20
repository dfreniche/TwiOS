//
//  DFTwitterHelper.h
//  TwiOS
//
//  Created by Diego Freniche Brito on 29/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#import "DFTwitterAccountInfo.h"

@interface DFTwitterHelper : NSObject

+ (void)twitterAccountInfoWithUser:(NSString *)twitterUser completion:(void(^)(DFTwitterAccountInfo *))completion;
+ (void)readTweetsWithCompletion:(void(^)(NSArray *))completion;

@end
