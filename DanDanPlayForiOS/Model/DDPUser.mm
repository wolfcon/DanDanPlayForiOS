//
//  DDPUser.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/4/18.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "DDPUser.h"
#import "DDPCacheManager+DB.h"

#import <WCDB/WCDB.h>
#import "DDPUser+WCTTableCoding.h"

DDPUserLoginType DDPUserLoginTypeWeibo = @"weibo";
DDPUserLoginType DDPUserLoginTypeQQ = @"qq";
DDPUserLoginType DDPUserLoginTypeDefault = @"dandanplay";

@interface DDPUser ()
@property (assign, nonatomic) NSTimeInterval lastUpdateTime;
@property (assign, nonatomic) BOOL isLogin;
@end

@implementation DDPUser

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
        return @{@"name" : @"screenName",
                 @"identity" : @"userId",
                 @"iconImgURL" : @"profileImage",
                 @"account" : @"userName",
                 @"JWTToken" : @"token"
                 };
}

- (void)updateLoginStatus:(BOOL)isLogin {
    _isLogin = isLogin;
    self.lastUpdateTime = [[NSDate date] timeIntervalSince1970];
    if (self.identity == [DDPCacheManager shareCacheManager].currentUser.identity) {
        [DDPCacheManager shareCacheManager].currentUser = self;        
    }
}

WCDB_IMPLEMENTATION(DDPUser)
WCDB_SYNTHESIZE(name)
WCDB_SYNTHESIZE(identity)
WCDB_SYNTHESIZE(JWTToken)
WCDB_SYNTHESIZE(tokenExpireTime)
WCDB_SYNTHESIZE(iconImgURL)
WCDB_SYNTHESIZE(userType)
WCDB_SYNTHESIZE(registerRequired)
WCDB_SYNTHESIZE(account)
WCDB_SYNTHESIZE(password)
WCDB_SYNTHESIZE(isLogin)
WCDB_SYNTHESIZE(lastUpdateTime)
WCDB_SYNTHESIZE(legacyTokenNumber)
WCDB_SYNTHESIZE(thirdPartyUserId)

WCDB_PRIMARY(identity)

@end
