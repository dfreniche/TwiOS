//
//  DFDirectMessage.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 12/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "DFDirectMessage.h"

@implementation DFDirectMessage

- (id)initWithJSONObject:(NSDictionary *)jsonObject {
    self = [super init];
    if (self) {
        _text = [jsonObject objectForKey:@"text"];
        _sender= [[jsonObject objectForKey:@"sender"] objectForKey:@"name"];
        _senderImageURL = [[jsonObject objectForKey:@"sender"] objectForKey:@"profile_image_url"];
    }
    return self;
}

@end
