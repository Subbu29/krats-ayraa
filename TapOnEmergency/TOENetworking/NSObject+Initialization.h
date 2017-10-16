//
//  NSObject+Initialization.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Initialization)


-(instancetype)initWithDictionary:(id)dict;
+(NSMutableArray *)arrayOfModelsFromDictionary:(id)dict;

@end
