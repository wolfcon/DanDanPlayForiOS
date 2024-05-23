//
//  DDPVideoCache.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/1/27.
//  Copyright © 2018年 JimHuang. All rights reserved.
//

#import "DDPVideoCache.h"
#import "DDPVideoCache+DB.h"

@implementation DDPVideoCache

WCDB_IMPLEMENTATION(DDPVideoCache)

WCDB_SYNTHESIZE(name)
WCDB_SYNTHESIZE(identity)
WCDB_SYNTHESIZE(fileHash)
WCDB_SYNTHESIZE(lastPlayTime)

WCDB_PRIMARY(fileHash)

@end
