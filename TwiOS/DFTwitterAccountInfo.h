//
//  DFTwitterAccount.h
//  TwiOS
//
//  Created by Diego Freniche Brito on 29/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

// Class to wrap the Twitter info for one user

#import <Foundation/Foundation.h>

@interface DFTwitterAccountInfo : NSObject

@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSUInteger followersCount;
@property (nonatomic) NSUInteger followingCount;
@property (nonatomic) NSUInteger tweetsCount;
@property (nonatomic, strong) NSString *profileImageStringURL;
@property (nonatomic, strong) NSString *bannerImageStringURL;
@property (nonatomic, copy) NSString *lastTweet;

@end
