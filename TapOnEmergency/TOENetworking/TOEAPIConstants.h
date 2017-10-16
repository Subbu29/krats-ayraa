//
//  TOEAPIConstants.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_ERROR_IMAGE @"API_Error"

typedef enum {
    STATUS_OK = 200,
    STATUS_INTERNAL_SERVER_ERROR = 501,
    STATUS_OBJECT_NOT_FOUND = 301,
    STATUS_NO_DATA = 404,
    STATUS_NO_INTERNET = 0
}API_RESPONSE_STATUS_CODE;


@interface TOEAPIConstants : NSObject

extern NSString* const TOE_WEB_API_URL;

+(NSMutableDictionary *)addHeaders;

#pragma mark - Error States Data -

extern NSString* const NO_INTERNET_CONNECTION_MESSAGE;
extern NSString* const NO_DATA_FOUND_MESSAGE;
extern NSString* const INTERNAL_SERVER_ERROR_MESSAGE;
extern NSString* const OBJECT_NOT_FOUND_MESSAGE;

extern NSString* const NO_INTERNET_CONNECTION_IMAGE;
extern NSString* const NO_DATA_FOUND_IMAGE;
extern NSString* const INTERNAL_SERVER_ERROR_IMAGE;
extern NSString* const OBJECT_NOT_FOUND_IMAGE;


@end
