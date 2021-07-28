//
//  GModelManger.h
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import "NSObject+GObject.h"
@class GModel;
NS_ASSUME_NONNULL_BEGIN



@interface GModelManger : NSObject<GHelperProtocol>

@property (strong,readonly, nonatomic)Class dbModelClass;
@property (strong,readonly, nonatomic)id dbShard;

/// 获取持久化
+(GModel*)archiveGetWithClass:(Class)classModel;
/// 删除持久化数据
+(void)archiveDelWithClass:(Class)classModel;
/// 更新持久化数据
+(void)archiveUpdateWithClass:(Class)classModel with:(__kindof GModel*)model;
/// classModel 需要继承GModel
+(__kindof GModel *)archiveWithClass:(Class)classModel wtihBlock:(void (^)(__kindof GModel* modelSub))block;




/// 插入数据
/// @param model 数据类型，需要继承GModel且实现DBMangerProtocol协议
+(void)insertWithModel:(GModel*)model;
/// 批量插入数据
+(void)insertWithModels:(NSArray<GModel*>*)models;
/// 删除数据
+(void)delWithModel:(GModel*)model;

/// 删除数据
/// model需要包涵主键
/// @param strID 或者根据id删除数据
+(void)delWithModel:(GModel*)model withORID:(NSString* _Nullable )strID;

/// 更新数据
+(void)updateWithModel:(GModel*)model;

 /// 查询所有数据
+(NSArray<GModel*>*)queryFromTableWithMarkClass:(Class)clasS;

 /// 根据id查询批量数据
+(NSArray<GModel*>*)queryFromTableWithIDArray:(NSArray<NSString*>*)idArray withMarkClass:(Class)clasS;

/// 是否已经储存过了
+(BOOL)isContainsWith:(GModel*)model;

///多个表切换的时候
+(void)dbTableChangeBLock:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
