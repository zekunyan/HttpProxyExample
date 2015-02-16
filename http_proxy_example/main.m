//
//  main.m
//  http_proxy_example
//
//  Created by zorro on 15/2/16.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "HttpProxy.h"
#import "UserHttpHandlerImp.h"
#import "CommentHttpHandlerImp.h"

int main(int argc, const char *argv[]) {
    
    @autoreleasepool {
        //Init and register http handler
        [[HttpProxy sharedInstance] registerHttpProtocol:@protocol(UserHttpHandler) handler:[UserHttpHandlerImp new]];
        [[HttpProxy sharedInstance] registerHttpProtocol:@protocol(CommentHttpHandler) handler:[CommentHttpHandlerImp new]];
        
        //Call
        [[HttpProxy sharedInstance] getUserWithID:@100];
        [[HttpProxy sharedInstance] getCommentsWithDate:[NSDate new]];
    }
    return 0;
}
