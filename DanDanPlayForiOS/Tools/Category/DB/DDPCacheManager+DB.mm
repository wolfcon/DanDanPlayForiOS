//
//  DDPCacheManager+DB.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/1/27.
//  Copyright © 2018年 JimHuang. All rights reserved.
//

#import "DDPCacheManager+DB.h"
#import "DDPFilter.h"
#import "DDPVideoCache.h"
#import "DDPSMBFileHashCache.h"
#import "DDPCollectionCache.h"
#import "DDPLinkInfo.h"
#import "DDPSMBDownloadTaskCache.h"
#import "DDPUser+WCTTableCoding.h"
#import "DDPWebDAVHasnCache+WCTTableCoding.h"

@implementation DDPCacheManager (DB)

+ (WCTDatabase *)shareDB {
    static WCTDatabase *_database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _database = [[WCTDatabase alloc] initWithPath:[[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"DDPConfig.db"]];
        [_database createTable:DDPFilter.className withClass:DDPFilter.class];
        [_database createTable:DDPVideoCache.className withClass:DDPVideoCache.class];
        [_database createTable:DDPSMBFileHashCache.className withClass:DDPSMBFileHashCache.class];
        [_database createTable:DDPCollectionCache.className withClass:DDPCollectionCache.class];
        [_database createTable:DDPLinkInfo.className withClass:DDPLinkInfo.class];
        [_database createTable:DDPSMBInfo.className withClass:DDPSMBInfo.class];
        [_database createTable:DDPUser.className withClass:DDPUser.class];
        [_database createTable:DDPWebDAVLoginInfo.className withClass:DDPWebDAVLoginInfo.class];
        [_database createTable:DDPWebDAVHasnCache.className withClass:DDPWebDAVHasnCache.class];
#if !DDPAPPTYPE
        [_database createTable:DDPSMBDownloadTaskCache.className withClass:DDPSMBDownloadTaskCache.class];
//        [_database createTable:DDPLinkDownloadTask.className withClass:DDPLinkDownloadTask.class];
#endif
    });
    return _database;
}

@end
