//
//  BuglyConfig.h
//  Bugly
//
//  Copyright (c) 2016年 Tencent. All rights reserved.
//

#pragma once

#define BLY_UNAVAILABLE(x) __attribute__((unavailable(x)))

#if __has_feature(nullability)
#define BLY_NONNULL __nonnull
#define BLY_NULLABLE __nullable
#define BLY_START_NONNULL _Pragma("clang assume_nonnull begin")
#define BLY_END_NONNULL _Pragma("clang assume_nonnull end")
#else
#define BLY_NONNULL
#define BLY_NULLABLE
#define BLY_START_NONNULL
#define BLY_END_NONNULL
#endif

#import <Foundation/Foundation.h>

// Log level for Bugly Log
typedef NS_ENUM(NSUInteger, BuglyLogLevel) {
    BuglyLogLevelSilent  = 0,
    BuglyLogLevelError   = 1,
    BuglyLogLevelWarn    = 2,
    BuglyLogLevelInfo    = 3,
    BuglyLogLevelDebug   = 4,
    BuglyLogLevelVerbose = 5,
};

BLY_START_NONNULL

/// bugly crash上报信息
@interface BuglyExceptionReportInfo : NSObject
/**
 *  发生crash时间(ms)
 */
@property (nonatomic, assign) long long crashTime;

/**
 *  发生crash时的用户id
 */
@property (nonatomic, copy, nullable) NSString *userid;

/**
 *  发生crash时的设备id
 */
@property (nonatomic, copy, nullable) NSString *deviceId;

/**
 *  发生crash时是否在后台
 */
@property (nonatomic, assign) BOOL isBackground;

/**
 *  发生crash时的设备总内存
 */
@property (nonatomic, copy, nullable) NSString *totoalMemory;

/**
 *  发生crash时的剩余内存
 */
@property (nonatomic, copy, nullable) NSString *freeMemeory;

/**
 *  发生crash时的crash.log的序列化
 */
@property (nonatomic, strong, nullable) NSData *crashLogData;

@end

@protocol BuglyDelegate <NSObject>

@optional

/**
 *  抛出崩溃时的上报信息
 *
 *  @param exceptionReportInfo 上报信息
 */
- (void)handleExceptionReportInfo:(BuglyExceptionReportInfo *)exceptionReportInfo;

/**
 *  发生异常时回调
 *
 *  @param exception 异常信息
 *
 *  @return 返回需上报记录，随异常上报一起上报
 */
- (NSString * BLY_NULLABLE)attachmentForException:(NSException * BLY_NULLABLE)exception;

/**
 *  发生sigkill时回调
 *
 *  @param exception 异常信息
 *
 *  @return 返回需上报记录，随sigkill异常上报一起上报，返回值由app开发者决定
 */
- (NSString * BLY_NULLABLE)attachmentForSigkill;

/**
 *  策略激活时回调
 *
 *  @param tacticInfo
 *
 *  @return app是否弹框展示
 */
- (BOOL) h5AlertForTactic:(NSDictionary *)tacticInfo;

/**
 *  发生卡顿时回调
 *  @param timeInterval 卡顿持续时间
 */
- (void)blockDurationTime:(NSTimeInterval)timeInterval;

@end

@interface BuglyConfig : NSObject

/// appid, 详见 https://bugly.oa.com/ 产品配置 - appid
@property (nonatomic, copy) NSString *appId;

/// appkey, 详见 https://bugly.oa.com/ 产品配置 - appkey
@property (nonatomic, copy) NSString *appKey;

/// SDK Debug信息开关, 默认关闭
@property (nonatomic, assign) BOOL debugMode;
/// 是否开发设备
@property (nonatomic, assign) BOOL development;
/// 设置自定义渠道标识
@property (nonatomic, copy) NSString *channel;
/// 设置自定义版本号
@property (nonatomic, copy) NSString *version;
/// 设置自定义设备唯一标识
@property (nonatomic, copy) NSString *deviceIdentifier;
/// 自定义用户id
@property (nonatomic, copy) NSString *userIdentifier;

///  设置 App Groups Id (如有使用 Bugly iOS Extension SDK，请设置该值)
@property (nonatomic, copy) NSString *applicationGroupIdentifier;

/// 卡顿监控开关，默认关闭
@property (nonatomic) BOOL blockMonitorEnable;

/// 卡顿监控判断间隔，单位为秒
@property (nonatomic) NSTimeInterval blockMonitorTimeout;

/// 卡顿监控检测到卡顿立即上报开关，默认关闭，only for extension
@property (nonatomic) BOOL blockReportImmediately;

/// 崩溃监控开关，默认关闭，only for extension
@property (nonatomic) BOOL crashMonitorEnable;

/// 卡顿监控检测到卡顿次数统计开关，默认关闭，only for extension
@property (nonatomic) BOOL blockCountMonitorEnable;

/// 卡顿监控检测到卡顿调用堆栈上报开关，默认关闭，only for extension
@property (nonatomic) BOOL blockReportCallStackEnable;

/// 进程内还原开关，默认开启
@property (nonatomic) BOOL symbolicateInProcessEnable;

/// 非正常退出事件记录开关，默认关闭
@property (nonatomic) BOOL unexpectedTerminatingDetectionEnable;

/// 页面信息记录开关，默认开启
@property (nonatomic) BOOL viewControllerTrackingEnable;

/// Bugly Delegate
@property (nonatomic, assign) id<BuglyDelegate> delegate;

/// 控制自定义日志上报，默认值为BuglyLogLevelSilent，即关闭日志记录功能。
/// 如果设置为BuglyLogLevelWarn，则在崩溃时会上报Warn、Error接口打印的日志
@property (nonatomic, assign) BuglyLogLevel reportLogLevel;

/// 崩溃数据过滤器，如果崩溃堆栈的模块名包含过滤器中设置的关键字，则崩溃数据不会进行上报
/// 例如，过滤崩溃堆栈中包含搜狗输入法的数据，可以添加过滤器关键字SogouInputIPhone.dylib等
@property (nonatomic, copy) NSArray *excludeModuleFilter;

/// 控制台日志上报开关，默认开启
@property (nonatomic, assign) BOOL consolelogEnable;

/// C++异常捕获增加新的捕获方式开关 默认开启
@property (nonatomic, assign) BOOL cppNewOptEnable;

/**
 * 崩溃退出超时，如果监听到崩溃后，App一直没有退出，则到达超时时间后会自动abort进程退出
 * 默认值 5s， 单位 秒
 * 当赋值为0时，则不会自动abort进程退出
 */
@property (nonatomic, assign) NSUInteger crashAbortTimeout;

/// 设置自定义联网、crash上报域名
@property (nonatomic, copy) NSString *crashServerUrl;

/**
 *  设置自定义Bundle Identifier
 *  实现多Bundle Identifier的数据在后台按照异常类型（crash、block）进行聚合展示
 *  设置此字段，异常上报中的Bundle Identifier使用自定义的Bundle Identifier，未设置则使用plist中的Bundle Identifier
 *  备注：多个Bundle Identifier使用相同的自定义Bundle Identifier上报异常数据，可使用如下接口：+ (void)setUserValue:(NSString *)value
         forKey:(NSString *)key 设置实际的Bundle Identifier对上报的异常数据进行区分
 */
@property (nonatomic, copy) NSString *customizedBundleIdentifier;

#pragma mark - 个人信息采集开关（默认均为 YES，按需关闭）

/// 设置是否开启全部个人信息采集项，默认 YES，仅在 SDK 初始化前调用。
- (void)setEnableAllPersonalInfoCollection:(BOOL)enable;

/// 设置是否采集操作系统版本，默认 YES
- (void)setEnableSystemVersion:(BOOL)enable;
/// 设置是否采集操作系统内部版本号(Build)，默认 YES
- (void)setEnableSystemVersionCode:(BOOL)enable;
/// 设置是否采集设备型号，默认 YES
- (void)setEnableDeviceModel:(BOOL)enable;
/// 设置是否采集内存剩余/总内存，默认 YES
- (void)setEnableFreeMemory:(BOOL)enable;
/// 设置是否采集磁盘空间，默认 YES
- (void)setEnableDiskSpace:(BOOL)enable;
/// 设置是否采集网络/wifi状态，默认 YES
- (void)setEnableNetworkType:(BOOL)enable;
/// 设置是否采集 CPU 属性，默认 YES
- (void)setEnableCpuInfo:(BOOL)enable;
/// 设置是否采集运行时进程内存状态(进程所占内存，虚拟内存)，默认 YES
- (void)setEnableProcessMemory:(BOOL)enable;
/// 设置是否采集越狱状态，默认 YES
- (void)setEnableJailbreakStatus:(BOOL)enable;
/// 设置是否采集地区编码，默认 YES
- (void)setEnableCountryCode:(BOOL)enable;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// @brief init
/// @param appId 详见 http://bugly.oa.com/, 项目管理 - 产品配置 - appid
/// @param appKey 详见 http://bugly.oa.com/, 项目管理 - 产品配置 - appkey
- (instancetype)initWithAppId:(NSString *)appId appKey:(NSString *)appKey;

@end
BLY_END_NONNULL
