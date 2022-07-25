//
//  DDPBackNormalFooter.m
//  DDPlay
//
//  Created by Frank on 2022/7/22.
//  Copyright © 2022 JimHuang. All rights reserved.
//

#import "DDPBackNormalFooter.h"

@implementation DDPBackNormalFooter

- (instancetype)init {
    if (self = [super init]) {
        self.stateLabel.font = [UIFont ddp_normalSizeFont];
        [self setTitle:@"没了, 一滴都没了" forState:MJRefreshStateNoMoreData];
        [self setTitle:@"" forState:MJRefreshStateIdle];
        [self setTitle:@"" forState:MJRefreshStatePulling];
    }
    return self;
}

- (void)setState:(MJRefreshState)state {
    if (state == MJRefreshStateRefreshing) {
        self.labelLeftInset = 20;
        [self setTitle:[[DDPCacheManager shareCacheManager].refreshTexts randomObject] forState:MJRefreshStateRefreshing];
        self.loadingView.hidden = false;
    }
    else {
        self.labelLeftInset = 0;
        self.loadingView.hidden = true;
    }
    
    [super setState:state];
}

@end
