//
//  DDPWebDAVLoginInfo+DB.m
//  DDPlay
//
//  Created by JimHuang on 2020/6/7.
//  Copyright © 2020 JimHuang. All rights reserved.
//

#import "DDPWebDAVLoginInfo+DB.h"

@implementation DDPWebDAVLoginInfo (DB)
WCDB_IMPLEMENTATION(DDPWebDAVLoginInfo)

WCDB_SYNTHESIZE(userName)
WCDB_SYNTHESIZE(userPassword)
WCDB_SYNTHESIZE(path)

WCDB_MULTI_PRIMARY("ddp_m_p", path)
@end
