//
//  DFTweet.h
//  TwiOS
//
//  Created by Diego Freniche Brito on 20/01/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class encapsulates Tweet info as returned by DFTwitterHelper
 */
@interface DFTweet : NSObject

/** The tweet text
 */
@property (nonatomic, copy) NSString *text;

/** Program used to post the tweet */
@property (nonatomic, copy) NSString *source;

/** Name of User that tweeted */
@property (nonatomic, copy) NSString *userName;

/** Number of times this tweet has been faved */
@property (nonatomic) NSUInteger favoriteCount;

/** Number of times this tweet has been retweeted */
@property (nonatomic) NSUInteger retweetCount;

- (id)initWithJSONObject:(NSDictionary *)jsonObject NS_DESIGNATED_INITIALIZER;

@end
