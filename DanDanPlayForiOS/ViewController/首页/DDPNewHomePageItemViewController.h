//
//  DDPNewHomePageItemViewController.h
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/10/4.
//  Copyright © 2018 JimHuang. All rights reserved.
//

#import "DDPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPNewHomePageItemViewController : DDPBaseViewController
@property (strong, nonatomic) NSArray <DDPNewBangumiIntro *>*bangumis;
@property (nonatomic) BOOL isMyAttention;
@end

NS_ASSUME_NONNULL_END
