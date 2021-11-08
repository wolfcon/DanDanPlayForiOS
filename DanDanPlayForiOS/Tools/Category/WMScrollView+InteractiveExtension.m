//
//  WMScrollView+InteractiveExtension.m
//  DDPlay
//
//  Created by Frank on 2021/11/8.
//  Copyright © 2021 JimHuang. All rights reserved.
//

#import "WMScrollView+InteractiveExtension.h"

@implementation WMScrollView (InteractiveExtension)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // iOS横向滚动的scrollView和系统pop手势返回冲突的解决办法:     http://blog.csdn.net/hjaycee/article/details/49279951

    // 兼容系统pop手势 / FDFullscreenPopGesture / 如有自定义手势，需自行在此处判断
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }

    // ReSideMenu 及其他一些手势的开启，需要在这自行
    // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
//    BOOL contentOffsetEnable = (self.contentOffset.x == 0 || self.contentOffset.x == self.contentSize.width - self.bounds.size.width);
//    if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && contentOffsetEnable) {
//        return YES;
//    }
    return NO;
}

@end
