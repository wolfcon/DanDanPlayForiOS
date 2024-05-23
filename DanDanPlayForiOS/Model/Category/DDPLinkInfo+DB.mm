//
//  DDPLinkInfo+DB.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/1/27.
//  Copyright © 2018年 JimHuang. All rights reserved.
//

#import "DDPLinkInfo+DB.h"

@implementation DDPLinkInfo (DB)

WCDB_IMPLEMENTATION(DDPLinkInfo)
WCDB_SYNTHESIZE(name)
WCDB_SYNTHESIZE(ipAdress)
WCDB_SYNTHESIZE(selectedIpAdress)
WCDB_SYNTHESIZE(port)
WCDB_SYNTHESIZE(currentUser)
WCDB_SYNTHESIZE(saveTime)

WCDB_PRIMARY(selectedIpAdress)

@end
