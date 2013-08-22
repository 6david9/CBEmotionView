//
//  NSObject+Runtime.m
//  CBExtension
//
//  Created by  ly on 13-6-15.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

- (NSArray *)conformedProtocols
{
    unsigned int outCount = 0;
    Class obj_class = [self class];
    __unsafe_unretained Protocol **protocols = class_copyProtocolList(obj_class, &outCount);
    
    NSMutableArray *protocol_array = nil;
    if (outCount > 0)
    {
        protocol_array = [[NSMutableArray alloc] initWithCapacity:outCount];
        
        for (NSInteger i = 0; i < outCount; i++)
        {
            NSString *protocol_name_string;
            const char *protocol_name = protocol_getName(protocols[i]);
            protocol_name_string = [[NSString alloc] initWithCString:protocol_name
                                                            encoding:NSUTF8StringEncoding];
            [protocol_array addObject:protocol_name_string];
        }
    }
    
    return protocol_array;
}

- (NSArray *)allProperties
{
    unsigned int count = 0;
    objc_property_t *property_ptr = NULL;
    property_ptr = class_copyPropertyList([self class], &count);
    
    if ( !property_ptr ) {
        return [NSArray array];
    }
    
    NSMutableArray *all = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i++)
    {
        @autoreleasepool {
            NSString *property = propertyName(property_ptr[i]);
            [all addObject:property];
        }
    }
    free(property_ptr);
    return all;
}

- (NSArray *)allIvars
{
    unsigned int count = 0;
    Ivar *ivar_ptr = NULL;
    ivar_ptr = class_copyIvarList([self class], &count);
    
    if ( !ivar_ptr ) {
        return [NSArray array];
    }
    
    NSMutableArray *all = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i++)
    {
        @autoreleasepool {
            NSString *ivar = ivarName(ivar_ptr[i]);
            [all addObject:ivar];
        }
    }
    free(ivar_ptr);
    return all;
}

#define ALL_METHOD_BODY \
unsigned int count = 0;\
Method *method_ptr = NULL;\
method_ptr = class_copyMethodList([self class], &count);\
\
if ( !method_ptr ) {\
return [NSArray array];\
}\
\
NSMutableArray *all = [[NSMutableArray alloc] initWithCapacity:count];\
for (NSInteger i = 0; i < count; i++)\
{\
@autoreleasepool {\
NSString *m = methodName(method_ptr[i]);\
[all addObject:m];\
}\
}\
free(method_ptr);\
return all;

+ (NSArray *)allMethods
{
    ALL_METHOD_BODY
}

- (NSArray *)allMethods
{
    ALL_METHOD_BODY
}

- (NSArray *)allMethodsWithAdopted
{
    Class selfClass = object_getClass(self);
    NSMutableArray *all = [[NSMutableArray alloc] initWithCapacity:0];
    [all addObject: keyValueForClass(selfClass) ];
    
    Class aClass = class_getSuperclass(selfClass);
    while (aClass != nil)
    {
        @autoreleasepool {
            NSDictionary *pair = keyValueForClass(aClass);
            [all addObject:pair];
            
            aClass = class_getSuperclass(aClass);
        }
    }
    
    return all;
}

- (NSArray *)parents
{
    Class selfClass = object_getClass(self);
    NSMutableArray *all = [[NSMutableArray alloc] initWithCapacity:0];
    
    Class aClass = class_getSuperclass(selfClass);
    while (aClass != nil)
    {
        @autoreleasepool {
            [all addObject: NSStringFromClass(aClass) ];
            aClass = class_getSuperclass(aClass);
        }
    }
    return all;
}

- (NSString *)className
{
    return NSStringFromClass(object_getClass(self));
}

#pragma mark - Inline method
/*! 以 NSString 类型返回 property名称 */
static inline
NSString *
propertyName(objc_property_t property)
{
    const char *name = property_getName(property);
    return [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
}

/*! 以 NSString 类型返回 ivar 名称 */
static inline
NSString *
ivarName(Ivar ivar)
{
    const char *name = ivar_getName(ivar);
    return [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
}

/*! 以 NSString 类型返回 method 名称 */
static inline
NSString *
methodName(Method m)
{
    return NSStringFromSelector(method_getName(m));
}

/*! 生成由类名和实例方法租出的字典文件
 * @discussion: key: 类名, value: 对象的实例方法
 */
static inline
NSDictionary *
keyValueForClass(Class aClass)
{
    id obj = [aClass new];
    NSString *key = NSStringFromClass(aClass);
    NSArray *value = [obj allMethods];
    
    return @{key : value};
}

@end
