//
//  TOEAPIConstants.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "TOEAPIConstants.h"

@implementation TOEAPIConstants

NSString* const TOE_WEB_API_URL = @"https://taponemergency.com/web/m/v1/";


+(NSMutableDictionary *)addHeaders
{
    NSMutableDictionary *headersMutableDictionary = [[NSMutableDictionary alloc] init];
    
    [headersMutableDictionary setValue:@"application/json" forKey:@"Content-Type"];
    
    return headersMutableDictionary;
}

NSString* const NO_INTERNET_CONNECTION_MESSAGE = @"Oops,you're offline";
NSString* const NO_DATA_FOUND_MESSAGE = @"Uh-oh, no Hospitals found";
NSString* const INTERNAL_SERVER_ERROR_MESSAGE = @"No image and message";
NSString* const OBJECT_NOT_FOUND_MESSAGE = @"No image and message";

NSString* const NO_INTERNET_CONNECTION_IMAGE = @"NoInternetConnectionImage";
NSString* const NO_DATA_FOUND_IMAGE = @"NoDataAvailableImage";
NSString* const INTERNAL_SERVER_ERROR_IMAGE = @"NOimage";
NSString* const OBJECT_NOT_FOUND_IMAGE = @"NOimage";


@end
