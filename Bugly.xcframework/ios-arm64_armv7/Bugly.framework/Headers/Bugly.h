//
//  Bugly.h
//
//  Version: 2.0(1)
//
//  Copyright (c) 2017年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BuglyConfig.h"
#import "RMonitorLoggerDefine.h"

BLY_START_NONNULL

@interface Bugly : NSObject


/**
 *  初始化Bugly
 *
 *  @param config 传入配置的 BuglyConfig
 */
+ (void)startWithConfig:(BuglyConfig *)config;

/**
 * 初始化Bugly
 *
 * @param pluginArr 启用的模块，默认使用 RM_MODULE_ALL
 * @param config 传入配置的 BuglyConfig
 */
+ (void)start:(NSArray<NSString *> *)pluginArr
       config:(BuglyConfig *)config;

/**
 *  更新版本信息
 *
 *  @param version 应用版本信息
 */
+ (void)updateAppVersion:(NSString *)version;

/**
 *  设置关键数据，随崩溃信息上报
 *
 *  @param value KEY
 *  @param key VALUE
 */
+ (void)setUserValue:(NSString *)value
              forKey:(NSString *)key;

/**
 *  获取USER ID
 *
 *  @return USER ID
 */
+ (NSString *)buglyUserIdentifier;

/**
 *  获取关键数据
 *
 *  @return 关键数据
 */
+ (NSDictionary * BLY_NULLABLE)allUserValues;

/**
 *  设置标签
 *
 *  @param tag 标签ID，可在网站生成
 */
+ (void)setTag:(NSUInteger)tag;

/**
 *  获取当前设置标签
 *
 *  @return 当前标签ID
 */
+ (NSUInteger)currentTag;

/**
 *  获取设备ID
 *
 *  @return 设备ID
 */
+ (NSString *)buglyDeviceId;

/**
 *  上报自定义Objective-C异常
 *
 *  @param exception 异常信息
 */
+ (void)reportException:(NSException *)exception;

/**
 *  上报错误
 *
 *  @param error 错误信息
 */
+ (void)reportError:(NSError *)error;

/**
 *    @brief 上报自定义错误
 *
 *    @param category    类型(Cocoa=3,CSharp=4,JS=5,Lua=6)
 *    @param aName       名称
 *    @param aReason     错误原因
 *    @param aStackArray 堆栈
 *    @param info        附加数据
 *    @param terminate   上报后是否退出应用进程
 */
+ (void)reportExceptionWithCategory:(NSUInteger)category
                               name:(NSString *)aName
                             reason:(NSString *)aReason
                          callStack:(NSArray *)aStackArray
                          extraInfo:(NSDictionary *)info
                       terminateApp:(BOOL)terminate;

/**
 *  SDK 版本信息
 *
 *  @return SDK版本号
 */
+ (NSString *)sdkVersion;

/**
 *  APP 版本信息
 *
 *  @return SDK版本号
 */
+ (NSString *)appVersion;

/**
 *  App 是否发生了连续闪退
 *  如果 启动SDK 且 5秒内 闪退，且次数达到 3次 则判定为连续闪退
 *
 *  @return 是否连续闪退
 */
+ (BOOL)isAppCrashedOnStartUpExceedTheLimit;

/**
 *  关闭bugly监控
 */
+ (void)closeCrashReport;

/// 关闭bugly所有监控，only for extension
+ (void)closeBuglyMonitor;

/// 注册日志函数指针
/// @param logger 日志函数
+ (void)registerLogCallback:(RMLogCallback)logger;

/// 更新userId
/// @param userId 用户id
+ (void)updateUserIdentifier:(NSString *)userId;

/// 更新设备id
/// @param deviceId 设备id
+ (void)updateDeviceIdentifier:(NSString *)deviceId;

/// 更新场景信息
/// @param scene 场景id，卡顿、内存、资源监控等功能会根据该值进行聚类
+ (void)setScene:(NSString *)scene;

/// 重置自定义场景信息，继续使用 RMonitor 自动获取的场景信息
+ (void)resetScene;


BLY_END_NONNULL

@end
