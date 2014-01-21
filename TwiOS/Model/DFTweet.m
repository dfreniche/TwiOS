//
//  DFTweet.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 20/01/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "DFTweet.h"

@implementation DFTweet

- (id)initWithJSONObject:(NSDictionary *)jsonObject {
    self = [super init];
    
    if (self) {
        if (jsonObject) {
            _text = [jsonObject valueForKey:@"text"];
            _source = [jsonObject valueForKey:@"source"];
            _userName = [[jsonObject valueForKey:@"user"] valueForKey:@"name"];
            _favoriteCount = [[jsonObject valueForKey:@"favorite_count"] integerValue];
            _retweetCount =[[jsonObject valueForKey:@"retweet_count"] integerValue];
        }
    }
    return self;
}


@end
