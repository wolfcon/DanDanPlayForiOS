//
//  DDPFile.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/4/28.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "DDPFile.h"
@interface DDPFile ()

@property (nonatomic) uint64_t fileSize;
@property (nonatomic) uint64_t allocationSize;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *accessDate;
@property (nonatomic, strong) NSDate *writeDate;
@property (nonatomic, strong) NSDate *modificationDate;

@end

@implementation DDPFile {
    DDPVideoModel *_videoModel;
}

- (instancetype)initWithFileURL:(NSURL *)fileURL type:(DDPFileType)type {
    if (self = [super init]) {
        _fileURL = fileURL;
        _type = type;
        
        NSString *filePath = fileURL.absoluteString;
        filePath = [filePath.stringByRemovingPercentEncoding stringByReplacingOccurrencesOfString:@"file:///" withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, filePath.length > 10 ? 10 : filePath.length)];
        NSError *error;
        NSDictionary<NSFileAttributeKey, id> *attributes = [NSFileManager.defaultManager attributesOfItemAtPath:filePath error:&error];
        if (error) {
            LOG_DEBUG(DDPLogModuleFile, @"获取数据信息失败：%@ \n\n%@",  fileURL, error.debugDescription);
            return self;
        }
        _modificationDate = attributes[NSFileModificationDate];
        _creationDate = attributes[NSFileCreationDate];
        _fileSize = (uint64_t)attributes[NSFileSize];
        _writeDate = attributes[NSFileModificationDate];
        _accessDate = _modificationDate;
        _allocationSize = _fileSize;
    }
    return self;
}

- (NSString *)name {
    return self.fileURL.lastPathComponent;
}

- (DDPVideoModel *)videoModel {
    if (_videoModel == nil) {
        _videoModel = [[DDPVideoModel alloc] initWithFileURL:self.fileURL];
        _videoModel.file = self;
    }
    return _videoModel;
}

- (NSMutableArray<DDPFile *> *)subFiles {
    if (_subFiles == nil) {
        _subFiles = [NSMutableArray array];
    }
    return _subFiles;
}

- (void)removeFromParentFile {
    NSMutableDictionary <NSString *, NSMutableArray <NSString *>*>*folderCache = (NSMutableDictionary <NSString *, NSMutableArray <NSString *>*> *)[DDPCacheManager shareCacheManager].folderCache;
    //从自定义文件夹缓存移除
    [folderCache enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray<NSString *> * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj removeObject:self.videoModel.quickHash];
    }];
    
    [DDPCacheManager shareCacheManager].folderCache = folderCache;
    
    [self.parentFile.subFiles removeObject:self];
}

- (NSUInteger)hash {
    return self.fileURL.hash;
}

- (BOOL)isEqual:(DDPFile *)object {
    if ([object isKindOfClass:[self class]] == NO) {
        return NO;
    }
    
    if (self == object) {
        return YES;
    }
    
    return [self.fileURL isEqual:object.fileURL];
}

@end
