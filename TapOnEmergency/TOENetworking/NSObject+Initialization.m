//
//  NSObject+Initialization.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "NSObject+Initialization.h"
#import <objc/runtime.h>

@implementation NSObject (Initialization)

-(instancetype)initWithDictionary:(id)dict{
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id obj = dict[propertyName];
        if(obj != (id)[NSNull null]  && obj != nil)
        [self setValue:obj forKey:propertyName];
    }
    
    return self;
}

+(NSMutableArray *)arrayOfModelsFromDictionary:(id)dict{
    NSMutableArray *returningArr = [NSMutableArray array];
    [dict enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSObject *object = [[self alloc] initWithDictionary:obj];
        [returningArr addObject:object];
    }];
    return returningArr;
}

@end
