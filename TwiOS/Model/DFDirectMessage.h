//
//  DFDirectMessage.h
//  TwiOS
//
//  Created by Diego Freniche Brito on 12/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFDirectMessage : NSObject

@property (nonatomic, copy) NSString *sender;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *senderImageURL;

- (id)initWithJSONObject:(NSDictionary *)jsonObject NS_DESIGNATED_INITIALIZER;


@end
