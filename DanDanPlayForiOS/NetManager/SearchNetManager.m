//
//  SearchNetManager.m
//  DanWanPlayer
//
//  Created by JimHuang on 15/12/24.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchNetManager.h"

@implementation SearchNetManager
+ (NSURLSessionDataTask *)searchOfficialWithKeyword:(NSString *)keyword episode:(NSUInteger)episode completionHandler:(void(^)(JHSearchCollection *responseObject, NSError *error))completionHandler {
    
    if (completionHandler == nil) return nil;
    
    if (!keyword.length){
        completionHandler(nil, parameterNoCompletionError());
        return nil;
    }
    
    NSString *path = nil;
    if (episode == 0) {
        path = [NSString stringWithFormat:@"%@/searchall/%@", API_PATH, [keyword stringByURLEncode]];
    }
    else {
        path = [NSString stringWithFormat:@"%@/searchall/%@/%ld", API_PATH, [keyword stringByURLEncode], episode];
    }
    
    return [self GETWithPath:path parameters:nil completionHandler:^(JHResponse *model) {
        completionHandler([JHSearchCollection yy_modelWithDictionary:model.responseObject], model.error);
    }];
}

+ (NSURLSessionDataTask *)searchBiliBiliWithkeyword:(NSString *)keyword completionHandler:(void(^)(JHBiliBiliSearchCollection *responseObject, NSError *error))completionHandler {
    
    if (completionHandler == nil) return nil;
    
    if (!keyword.length){
        completionHandler(nil, parameterNoCompletionError());
        return nil;
    }
    
    return [self GETWithPath:[@"http://biliproxy.chinacloudsites.cn/search/" stringByAppendingString:[keyword stringByURLEncode]] parameters:nil completionHandler:^(JHResponse *model) {
        completionHandler([JHBiliBiliSearchCollection yy_modelWithJSON:model.responseObject], model.error);
    }];
}

+ (NSURLSessionDataTask *)searchBiliBiliSeasonInfoWithSeasonId:(NSUInteger)seasonId completionHandler:(void(^)(JHBiliBiliBangumiCollection *responseObject, NSError *error))completionHandler {
    
    if (completionHandler == nil) return nil;
    
    if (seasonId == 0) {
        completionHandler(nil, parameterNoCompletionError());
        return nil;
    }
    
    NSString *path = [NSString stringWithFormat:@"http://bangumi.bilibili.com/jsonp/seasoninfo/%ld.ver?", seasonId];
    
    return [self GETDataWithPath:path parameters:nil completionHandler:^(JHResponse *model) {
        if ([model.responseObject isKindOfClass:[NSData class]]) {
            NSString *tempStr = [[NSString alloc] initWithData:model.responseObject encoding:NSUTF8StringEncoding];
            NSRange range = [tempStr rangeOfString:@"\\{.*\\}" options:NSRegularExpressionSearch];
            
            if (range.location != NSNotFound) {
                tempStr = [tempStr substringWithRange:range];
                NSError *err;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[tempStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
                completionHandler([JHBiliBiliBangumiCollection yy_modelWithDictionary: dic[@"result"]], err);
            }
            else {
                completionHandler(nil, parameterNoCompletionError());
            }
        }
        else {
            completionHandler(nil, model.error);
        }
    }];
}

@end