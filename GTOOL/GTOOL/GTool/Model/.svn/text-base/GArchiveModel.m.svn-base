//
//  GModel.m
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import "GArchiveModel.h"
#import <objc/runtime.h>
#import "NSObject+GObject.h"
#import "DBManger.h"

static DBManger * dbManger = nil;
@interface GArchiveModel()
@property(strong, nonatomic)NSMutableArray* array_Temp;

@end
@implementation GArchiveModel
GHELPER_SHARED(GArchiveModel)
-(instancetype)init{
    if (self = [super init]) {
        dbManger = [DBManger shared];
    }
    return self;
}

//-(GArchiveModel * _Nonnull (^)(ArchiveType))archiveWithType{
//    __weak typeof(self) weakSelf = self;
////    GArchiveModel* (^result)(ArchiveType type) = ^(ArchiveType type){
////        return weakSelf;
////
////      };
//    return ^(ArchiveType type){
//        return weakSelf;
//    };
//}






- (void)encodeWithCoder:(NSCoder *)aCoder
{
    _array_Temp = [NSMutableArray arrayWithCapacity:0];
    [self getAllproperNames];
    NSArray * properNames = _array_Temp;
    
    for (NSString * properName in properNames)
    {
        id value = [self valueForKey:properName];
        //归档到文件中
        if (!kISEmpty(value)) {
            [aCoder encodeObject:value forKey:properName];
        }
      
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        _array_Temp = [NSMutableArray arrayWithCapacity:0];
        [self getAllproperNames];
        NSArray * properNames = _array_Temp;
        
        for (NSString * properName in properNames)
        {
            id value = [aDecoder decodeObjectForKey:properName];
            if (!kISEmpty(value)) {
                [self setValue:value forKey:properName];
            }
           
        }
    }
    
    return self;
}
- (void)properNamesWithClass:(Class)cls
{
 
//    if ([cls isEqual:[NSObject class]] || cls == [NSObject class] || [cls isEqual:[GArchiveModel class]]  ) {
//        return;
//    }
    if ([cls isEqual:[NSObject class]] || cls == [NSObject class]  ) {
        return;
    }

    unsigned int count;
    
    Ivar * ivarList = class_copyIvarList(cls, &count);
    
    
    for (int i = 0; i<count; i++)
    {
        Ivar ivar = ivarList[i];
        //获取成员属性名
        NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //出去下划线
        NSString * key = [name substringFromIndex:1];
        if (![name isEqualToString:@"array_Temp"]) {
            [_array_Temp addObject:key];
        }
        
    }
    
    if ([cls respondsToSelector:@selector(superclass)] ) {
        if (self.superclass) {
         [self properNamesWithClass:cls.superclass];
        }
    }
}
-(void)getAllproperNames
{
    [self properNamesWithClass:[self class]];
 

}
-(NSMutableArray*)getAllproperNamesArray{
    _array_Temp = [NSMutableArray arrayWithCapacity:0];

       [self properNamesWithClass:[self class]];
    return _array_Temp;;
}
- (NSString *)description {
    
#if defined(DEBUG) && DEBUG
    unsigned int count;
    const char *clasName = object_getClassName(self);
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[",clasName, self];
    Class clas = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars = class_copyIvarList(clas, &count);
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            
            //得到类型
            NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            
            if ([key isEqualToString:@"_array_Temp"]) {
                break ;
            }
            id value = [self valueForKey:key];
            //确保BOOL 值输出的是YES 或 NO，这里的B是我打印属性类型得到的……
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }
            //            [string appendFormat:@"\t%@ = %@\n",[self delLine:key], value];
            [string appendFormat:@"  %@=%@  ",[self delLine:key], value];
            
        }
    }
    [string appendFormat:@"]"];

    return string;
    #endif
    return @"";
}

//去掉下划线
- (NSString *)delLine:(NSString *)string {
    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"-------------undefined  %@---------------",key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"-------------undefined  %@ : value: %@---------------",key,@"空");
    return @"";
}


-(void)convertForm:(GArchiveModel*)model{
    NSMutableArray* array =   [self getAllproperNamesArray];
    GArchiveModel* modelSuper =  model;
    NSMutableArray* arraySuper =   [modelSuper getAllproperNamesArray];
    [array enumerateObjectsUsingBlock:^(NSString* properNames, NSUInteger idx, BOOL * _Nonnull stop) {
        [arraySuper enumerateObjectsUsingBlock:^(NSString* properNameSuper, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([properNames isEqualToString:properNameSuper]) {
                if (kISEmpty([modelSuper valueForKey:properNames])) {
                    [self setValue:[modelSuper valueForKey:properNames]  forKey:properNames];
                }
                [arraySuper removeObject:properNameSuper];
            }
        }];
    }];
}


@end
