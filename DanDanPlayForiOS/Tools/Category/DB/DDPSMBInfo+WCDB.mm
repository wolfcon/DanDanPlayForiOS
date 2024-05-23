//
//  DDPSMBInfo+WCDB.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/1/28.
//  Copyright © 2018年 JimHuang. All rights reserved.
//

#import "DDPSMBInfo+WCDB.h"

@implementation DDPSMBInfo (DB)
WCDB_IMPLEMENTATION(DDPSMBInfo)

WCDB_SYNTHESIZE(hostName)
WCDB_SYNTHESIZE(ipAddress)
WCDB_SYNTHESIZE(userName)
WCDB_SYNTHESIZE(password)
WCDB_SYNTHESIZE(workGroup)

WCDB_MULTI_PRIMARY("ddp_m_p", hostName)
WCDB_MULTI_PRIMARY("ddp_m_p", userName)
WCDB_MULTI_PRIMARY("ddp_m_p", password)
@end
