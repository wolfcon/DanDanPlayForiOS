//
//  DDPFilter+DB.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/1/27.
//  Copyright © 2018年 JimHuang. All rights reserved.
//

#import "DDPFilter+DB.h"

@implementation DDPFilter (DB)

WCDB_IMPLEMENTATION(DDPFilter)

WCDB_SYNTHESIZE(name)
WCDB_SYNTHESIZE(isRegex)
WCDB_SYNTHESIZE(content)
WCDB_SYNTHESIZE(enable)
WCDB_SYNTHESIZE(cloudRule)



WCDB_PRIMARY(name)

@end
