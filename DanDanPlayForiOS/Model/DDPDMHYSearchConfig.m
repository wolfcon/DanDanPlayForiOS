//
//  DDPDMHYSearchConfig.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/9/7.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "DDPDMHYSearchConfig.h"

@implementation DDPDMHYSearchConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetPage];
    }
    return self;
}

- (void)resetPage {
    self.page = 1;
}

- (void)nextPage {
    self.page += 1;
}

- (void)previousPage {
    self.page = self.page < 2 ? 1 : (self.page - 1);
}

@end
