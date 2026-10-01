//
//  RMonitorLoggerDefine.h
//  QAPM
//
//  Created by engleliu on 2021/3/2.
//  Copyright © 2021 cass. All rights reserved.
//

#ifndef RMonitorLoggerDefine_h
#define RMonitorLoggerDefine_h

#ifdef __cplusplus
extern "C" {
#endif

#define RM_MODULE_MEMORY @"RMMemoryMonitorPlugin"
#define RM_MODULE_LOOPER @"RMLooperMonitorPlugin"
#define RM_MODULE_LAUNCH_TIME @"RMLaunchMonitorPlugin"
#define RM_MODULE_YELLOW @"RMYellowMonitorPlugin"
#define RM_MODULE_METRICKIT @"RMMetricKitMonitorPlugin"
#define RM_MODULE_RESOURCE @"RMResourceMonitorPlugin"

#define RM_MODULE_NO_CRASH \
    @[RM_MODULE_MEMORY, RM_MODULE_LOOPER, RM_MODULE_LAUNCH_TIME, RM_MODULE_YELLOW, RM_MODULE_METRICKIT]

#define RM_MODULE_ALL RM_MODULE_NO_CRASH

/**
 日志级别
 */
typedef enum RMLoggerLevel {
    ///外发版本log
    RMLogLevelEvent = 0,
    ///灰度和内部版本log
    RMLogLevelInfo = 1,
    ///内部版本log
    RMLogLevelDebug = 2,
} RMLoggerLevel;

/**
 用于输出SDK调试log的回调
 */
typedef void (*RMLogCallback)(RMLoggerLevel level, const char *log);

#ifdef __cplusplus
}  // extern "C"
#endif

#endif /* RMonitorLoggerDefine_h */
