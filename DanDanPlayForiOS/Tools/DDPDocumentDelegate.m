//
//  DDPDocumentDelegate.m
//  DDPlay
//
//  Created by Frank on 2021/11/24.
//  Copyright © 2021 JimHuang. All rights reserved.
//

#import "DDPDocumentDelegate.h"
#import "DDPMethod.h"

@interface DDPDocumentDelegate () <UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate>

@end

@implementation DDPDocumentDelegate

+ (DDPDocumentDelegate *)shared {
    static DDPDocumentDelegate *sharedDelegate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDelegate = [[DDPDocumentDelegate alloc] init];
    });
    return sharedDelegate;
}

- (void)openFileAppInViewController:(UIViewController *)viewController {
    UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc]
                  initWithDocumentTypes:@[
        @"public.audiovisual-content",
        @"public.video.mkv"
    ]
                  inMode:UIDocumentPickerModeImport];
    documentPickerVC.delegate = self;
    [viewController presentViewController:documentPickerVC animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    [DDPMethod matchVideoURL:url
                  completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    if (urls.count > 1) {
        for (NSURL *url in urls) {
            NSURL *toURL = [UIApplication.sharedApplication.documentsURL URLByAppendingPathComponent:[url lastPathComponent]];
            [NSFileManager.defaultManager copyItemAtURL:url toURL:toURL error:nil];
        }
        return;
    }
    
    [DDPMethod matchVideoURL:urls.firstObject
                  completion:nil];
}

@end
