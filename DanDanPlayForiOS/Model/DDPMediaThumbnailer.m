//
//  DDPMediaThumbnailer.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/10/5.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "DDPMediaThumbnailer.h"

@interface DDPMediaThumbnailer ()<VLCMediaThumbnailerDelegate>

@end

@implementation DDPMediaThumbnailer
+ (instancetype)thumbnailerWithMedia:(VLCMedia *)media
                        block:(ParseCompletionAction)block {
    DDPMediaThumbnailer *thumbnailer = (DDPMediaThumbnailer *)[self thumbnailerWithMedia:media delegate:NSNull.null andVLCLibrary:VLCLibrary.sharedLibrary];
    thumbnailer.delegate = thumbnailer;
    
    thumbnailer.parseCompletionCallBack = block;
    return thumbnailer;
}

#pragma mark - VLCMediaThumbnailerDelegate
- (void)mediaThumbnailerDidTimeOut:(VLCMediaThumbnailer *)mediaThumbnailer {
    if (self.parseCompletionCallBack) {
        self.parseCompletionCallBack(nil);
    }
}

- (void)mediaThumbnailer:(VLCMediaThumbnailer *)mediaThumbnailer didFinishThumbnail:(CGImageRef)thumbnail {
    if (self.parseCompletionCallBack) {
        self.parseCompletionCallBack([[UIImage alloc] initWithCGImage:thumbnail]);
    }
}

@end
