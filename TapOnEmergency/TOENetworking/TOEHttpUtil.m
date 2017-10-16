//
//  TOEHttpUtil.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "TOEHttpUtil.h"
#import <AFNetworking.h>

@implementation TOEHttpUtil

+(void)getDataFromNetworkWithUrl:(NSString *)requestUrl :(NSDictionary *)jsonDict WithHeaders:(NSDictionary *)headerDict WithCompletionBlock:(ResponseBlock)block
{
    if(requestUrl != nil) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [headerDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:(NSString *)obj forHTTPHeaderField:key];
        }];
        
        [manager GET:requestUrl parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (block) {
                block(operation.responseObject,operation.response.statusCode);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (block) {
                block(operation.responseObject,operation.response.statusCode);
            }
        }];
    }
}

+(void)postDataFromNetworkWithUrl:(NSString *)requestUrl withParameters:(NSMutableDictionary *)postDataDict WithHeaders:(NSMutableDictionary *)headersDict WithCompletionBlock:(ResponseBlock)block
{
    if (requestUrl != nil) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [headersDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop){
            [manager.requestSerializer setValue:(NSString *)obj forHTTPHeaderField:key];
        }];
        
        [manager POST:requestUrl parameters:postDataDict
              success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"%@",operation.responseObject);
             block(operation,operation.response.statusCode);
         }
              failure:
         ^(AFHTTPRequestOperation *operation, NSError *error) {
             block(operation,operation.response.statusCode);
         }];
    }
}

@end
