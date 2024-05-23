//
//  DDPSMBFileHashCache+DB.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/1/27.
//  Copyright © 2018年 JimHuang. All rights reserved.
//

#import "DDPSMBFileHashCache+DB.h"

@implementation DDPSMBFileHashCache (DB)

WCDB_IMPLEMENTATION(DDPSMBFileHashCache)

WCDB_SYNTHESIZE(key)
WCDB_SYNTHESIZE(md5)
WCDB_SYNTHESIZE(date)

WCDB_PRIMARY(key)

@end
