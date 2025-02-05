//
//  DDPSharedNetManager.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2019/4/15.
//  Copyright © 2019 JimHuang. All rights reserved.
//

#import "DDPSharedNetManager.h"
#import "DDPBaseNetManager+Private.h"
#import <AFNetworking/AFNetworking.h>


@implementation DDPSharedNetManager

+ (DDPSharedNetManager *)sharedNetManager {
    static dispatch_once_t onceToken;
    static DDPSharedNetManager *manager = nil;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:DDPMethod.apiDomain];
        manager = [[self alloc] initWithBaseURL:url];
    });
    return manager;
}

+ (DDPSharedNetManager *)resNetManager {
    static dispatch_once_t onceToken;
    static DDPSharedNetManager *manager = nil;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:DDPMethod.searchResDomain];
        manager = [[self alloc] initWithBaseURL:url];
    });
    return manager;
}

- (void)resetJWTToken:(NSString *)token {
    if (token.length) {
        [self.HTTPSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    else {
        [self.HTTPSessionManager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
}

@end
