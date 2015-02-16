//
// Created by zorro on 15/2/16.
// Copyright (c) 2015 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserHttpHandler <NSObject>
- (void)getUserWithID:(NSNumber *)userID;
@end