//
//  UIColor+Tools.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/12/16.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "UIColor+Tools.h"

@implementation UIColor (Tools)

+ (UIColor *)ddp_mainColor {
//    return DDPRGBColor(51, 151, 252);
    // 黄色
//    return DDPRGBColor(243, 118, 47);
    // 蓝色
    return DDPRGBColor(33, 160, 221);
}

+ (UIColor *)ddp_backgroundColor {
    return [UIColor systemBackgroundColor];
}

+ (UIColor *)ddp_veryLightGrayColorLight {
    return DDPRGBColor(240, 240, 240);
}

+ (UIColor *)ddp_veryLightGrayColor {
    return UIColor.systemGray6Color;
}

+ (UIColor *)ddp_lightGrayColor {
    return UIColor.systemGray5Color;
}

+ (UIColor *)ddp_cellHighlightColor {
    return UIColor.systemGrayColor;
}

@end
