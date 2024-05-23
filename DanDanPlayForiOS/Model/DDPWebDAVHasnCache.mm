//
//  DDPWebDAVHasnCache.mm
//  DDPlay
//
//  Created by JimHuang on 2020/6/9.
//  Copyright © 2020 JimHuang. All rights reserved.
//

#import "DDPWebDAVHasnCache+WCTTableCoding.h"
#import "DDPWebDAVHasnCache.h"
#import <WCDB/WCDB.h>

@implementation DDPWebDAVHasnCache

WCDB_IMPLEMENTATION(DDPWebDAVHasnCache)

WCDB_SYNTHESIZE(key)
WCDB_SYNTHESIZE(md5)
WCDB_SYNTHESIZE(date)

WCDB_PRIMARY(key)

@end
