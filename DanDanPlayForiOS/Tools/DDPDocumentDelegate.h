//
//  DDPDocumentDelegate.h
//  DDPlay
//
//  Created by Frank on 2021/11/24.
//  Copyright © 2021 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDPDocumentDelegate : NSObject

@property (nonatomic, class, readonly) DDPDocumentDelegate *shared;

- (void)openFileAppInViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
