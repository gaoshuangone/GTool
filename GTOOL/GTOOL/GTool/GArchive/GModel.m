//
//  GModel.m
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import "GModel.h"
#import <objc/runtime.h>
#import "GModelManger.h"
@interface GModel()

@end
@implementation GModel
GHELPER_SHARED(GModel)
-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

//-(GModel * _Nonnull (^)(ArchiveType))archiveWithType{
//    __weak typeof(self) weakSelf = self;
////    GModel* (^result)(ArchiveType type) = ^(ArchiveType type){
////        return weakSelf;
////
////      };
//    return ^(ArchiveType type){
//        return weakSelf;
//    };
//}


- (NSMutableArray *)getProperties
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    Class targetClass = [self class];
    while (targetClass != [GModel class] && targetClass != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(targetClass, &outCount);
        for (i = 0; i < outCount; i++)
        {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            [props addObject:propertyName];
        }
        free(properties);
        targetClass = [targetClass superclass];
    }
    return props;
}



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [[self getProperties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        [[self getProperties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    
    return self;
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
            [string appendFormat:@"  %@=%@  ",key, value];
            
        }
    }
    [string appendFormat:@"]"];

    return string;
    #endif
    return @"";
}




-(void)g_convertForm:(GModel*)model{
    NSMutableArray* array =   [self getProperties];
    GModel* modelSuper =  model;
    NSMutableArray* arraySuper =   [modelSuper getProperties];
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"-------------undefined  %@---------------",key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"-------------undefined  %@ : value: %@---------------",key,@"空");
    return @"";
}



#pragma mark - 使用数据库储存需要设置
/// 生成表名 需要跟用户对应起来
+(NSString*)g_setDBTableNameMarker{
    return @"DBUserInfoModel_Name";

}
///根据表建立的模型
+(Class)g_setDBClassModelMarker{
    return  [self class];

}
/////筛选需要记录的表中的属性，为nil表示全部记录
//+(NSArray<NSString*>*)g_setDBExcludedProperties{
//    return @[@"userID"];
//
//}
///表中增删改查，需要的标示，表示要取GModel中一个属性来，多策略查询需要重新修改方法
//+(NSString*)g_setDBQueryMarker{
//    return NSStringFromClass([self class]);
//}

#pragma mark- 数据库储存提供的方法
///插入
-(void)g_dbInsert{
    [GModelManger insertWithModel:(GModel*)self];

}
-(void)g_dbInsertWithWithModels:(NSArray<GModel*>*)models{
    [GModelManger insertWithModels:models];
}
///删除
-(void)g_dbDel{
    [GModelManger delWithModel:(GModel*)self withORID:nil];
}
-(void)g_dbDelwithORQueryID:(NSString*)iD{
    [GModelManger delWithModel:(GModel*)self withORID:iD];
}

///更新
-(void)g_dbUpdate{
    [GModelManger updateWithModel:(GModel*)self];
}
///查询
+(NSArray<GModel*>*)g_dbQueryAll;{
    return  [GModelManger queryFromTableWithMarkClass:[self class]];
}
-(NSArray<GModel*>*)g_dbQueryWithIDArray:(NSArray<NSString*>*)idArray{
    return  [GModelManger queryFromTableWithIDArray:idArray withMarkClass:[self class]];
}
///是否已经储存过了
-(BOOL)g_dbIsContain{
    return  [GModelManger isContainsWith:(GModel*)self];
}
///需要切换表的时候
+(void)g_dbTableChangeBlock:(void (^)(void))block{
    [GModelManger dbTableChangeBLock:block];
}


#pragma mark - 使用归档储存需要设置
-(NSString*)g_setArchiveMarker{
    return NSStringFromClass([self class]);
}

#pragma mark- 归档储存提供的方法
///获取archive数据
+(__kindof GModel*)g_archiveGet{
    return  [GModelManger archiveGetWithClass:[self class]];
}

-(void)g_archiveUpdate{
    return  [GModelManger archiveUpdateWithClass:[self class] with:self];
}

////删除ArchiveModel
+(void)g_archiveDel{
    [GModelManger archiveDelWithClass:[self class]];
   
}
////更新ArchiveModel，可作为第一次赋值使用
+(__kindof GModel *)g_archiveWithBlock:(void (^)(__kindof GModel* modelSub))block{
    return  [GModelManger archiveWithClass:[self class] wtihBlock:block];
}
@end
