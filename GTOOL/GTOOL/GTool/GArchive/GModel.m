//
//  GModel.m
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import "GModel.h"
#import <objc/runtime.h>
#import "GDBManger.h"
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
    unsigned int mothCout_f = 0;
    Method *mothList_f = class_copyMethodList([self class], &mothCout_f);
    for(int i = 0; i < mothCout_f; i++)
    {
        Method temp_f = mothList_f[i];
//        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding = method_getTypeEncoding(temp_f);
        
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
    }
    
    free(mothList_f);
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
+(NSString*)g_setTableNameMarker{
    return @"DBUserInfoModel_Name";

}
///根据表建立的模型
+(Class)g_setClassModelMarker{
    return  [self class];

}
/////筛选需要记录的表中的属性，为nil表示全部记录
//+(NSArray<NSString*>*)g_excludedProperties{
//    return @[@"userID"];
//
//}
///表中增删改查，需要的标示，表示要取GModel中一个属性来，多策略查询需要重新修改方法
//+(NSString*)g_setDBQueryMarker{
//    return NSStringFromClass([self class]);
//}

#pragma mark- 数据库储存提供的方法
///插入
+(void)g_dbInsert{
    [GDBManger insertWithModel:(GModel*)self];

}
+(void)g_dbInsertWithWithModels:(NSArray<GModel*>*)models{
    [GDBManger insertWithModels:models];
}
///删除
+(void)g_dbDel{
    [GDBManger delWithModel:(GModel*)self withORID:nil];
}
+(void)g_dbDelWithORQueryID:(NSString*)iD{
    [GDBManger delWithModel:(GModel*)self withORID:iD];
}

///更新
+(void)g_dbUpdate{
    [GDBManger updateWithModel:(GModel*)self];
}
///查询
+(NSArray<GModel*>*)g_dbQueryAll{
    return  [GDBManger queryFromTableWithMarkClass:[self class]];
}
+(NSArray<GModel*>*)g_dbQueryWithIDArray:(NSArray<NSString*>*)idArray{
    return  [GDBManger queryFromTableWithIDArray:idArray withMarkClass:[self class]];
}
///是否已经储存过了
+(BOOL)g_dbIsContain{
    return  [GDBManger isContainsWith:(GModel*)self];
}
///需要切换表的时候
+(void)g_dbTableChangeBlock:(void (^)(void))block{
    [GDBManger dbTableChangeBLock:block];
}




@end
