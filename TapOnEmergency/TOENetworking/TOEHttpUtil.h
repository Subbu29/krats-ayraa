//
//  TOEHttpUtil.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^ResponseBlock)(AFHTTPRequestOperation *operation,NSInteger statusCode);

@interface TOEHttpUtil : NSObject



/*!
 * @author Subba Rao
 * @discussion GET API Call
 * @param requestUrl ,Params Dict,Headers,Response block
 */

+(void)getDataFromNetworkWithUrl:(NSString *)requestUrl :(NSDictionary *)jsonDict WithHeaders:(NSDictionary *)headerDict WithCompletionBlock:(ResponseBlock)block ;

/*!
 * @author Subba Rao
 * @discussion POST API Call
 * @param requestUrl ,Params Dict,Headers,Response block
 */

+(void)postDataFromNetworkWithUrl:(NSString *)requestUrl withParameters:(NSDictionary *)postDataDict WithHeaders:(NSMutableDictionary *)headersDict WithCompletionBlock:(ResponseBlock)block;


@end
