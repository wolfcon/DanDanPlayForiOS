//
//  DDPFile.h
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/4/28.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "DDPBase.h"
#import "TOSMBSessionFile+Tools.h"

@class DDPVideoModel;

typedef NS_ENUM(NSUInteger, DDPFileType) {
    DDPFileTypeUnknow,
    DDPFileTypeDocument,
    DDPFileTypeFolder,
};


@interface DDPFile : DDPBase
@property (assign, nonatomic) DDPFileType type;
@property (strong, nonatomic) NSURL *fileURL;
@property (strong, nonatomic, readonly) DDPVideoModel *videoModel;
- (instancetype)initWithFileURL:(NSURL *)fileURL type:(DDPFileType)type;

@property (strong, nonatomic) NSMutableArray <__kindof DDPFile *>*subFiles;
@property (weak, nonatomic) __kindof DDPFile *parentFile;
- (void)removeFromParentFile;
@end

@interface DDPFile (Info)

@property (nonatomic, readonly) uint64_t fileSize;         /** The file size, in bytes of this folder (0 if it's a folder) */
@property (nonatomic, readonly) uint64_t allocationSize;   /** The allocation size (ie how big it will be on disk) of this file */
@property (nonatomic, readonly) NSDate *creationDate;       /** The date and time that this file was created */
@property (nonatomic, readonly) NSDate *accessDate;         /** The date when this file was last accessed. */
@property (nonatomic, readonly) NSDate *writeDate;          /** The date when this file was last written to. */
@property (nonatomic, readonly) NSDate *modificationDate;   /** The date when this file was last modified. */

@end
