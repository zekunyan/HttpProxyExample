//
// Created by zorro on 15-1-20.
// Copyright (c) 2015 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHttpHandler.h"
#import "CommentHttpHandler.h"

@interface HttpProxy : NSProxy <UserHttpHandler, CommentHttpHandler>

+ (instancetype)sharedInstance;

- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler;
@end