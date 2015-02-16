//
// Created by zorro on 15-1-20.
// Copyright (c) 2015 zorro. All rights reserved.
//

#import <objc/runtime.h>
#import "HttpProxy.h"

@interface HttpProxy ()
@property(strong, nonatomic) NSMutableDictionary *selToHandlerMap;
@end

@implementation HttpProxy

#pragma mark - Public methods

+ (instancetype)sharedInstance {
    static HttpProxy *httpProxy = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpProxy = [HttpProxy alloc];
        httpProxy.selToHandlerMap = [NSMutableDictionary new];
    });

    return httpProxy;
}

- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler {
    unsigned int numberOfMethods = 0;

    //Get all methods in protocol
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(
            httpProtocol, YES, YES, &numberOfMethods);

    //Register protocol methods
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        struct objc_method_description method = methods[i];
        [_selToHandlerMap setValue:handler forKey:NSStringFromSelector(method.name)];
    }
}

#pragma mark - Methods route

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSString *methodsName = NSStringFromSelector(sel);
    id handler = [_selToHandlerMap valueForKey:methodsName];

    if (handler != nil && [handler respondsToSelector:sel]) {
        return [handler methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *methodsName = NSStringFromSelector(invocation.selector);
    id handler = [_selToHandlerMap valueForKey:methodsName];

    if (handler != nil && [handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
    } else {
        [super forwardInvocation:invocation];
    }
}

@end