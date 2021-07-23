//
//  GDBManger.h
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import "NSObject+GObject.h"
#import "GDBMangerProtocol.h"
@class GArchiveModel;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ArchiveType){
    ///DBArchiveModel
    kType_ArchiveModel=0,
    
    
    
    ///DBArchiveModel_dict。userdefault储存默认
    kType_ArchiveDict=10,

    
    
    ///DBArchiveModel_array
    kType_ArchiveArray=100,
    
};



@interface GDBManger : NSObject<GHelperProtocol>

@property (strong,readonly, nonatomic)Class dbModelClass;
@property (strong,readonly, nonatomic)id dbShard;

/// 获取持久化
/// @param type type 类型
+(GArchiveModel*)archiveGetWithType:(ArchiveType)type;
+(void)archiveDelWithType:(ArchiveType)type;
/// 获取持久化并重新赋值
/// @param type 类型
/// @param classModel 需要继承GArchiveModel
/// @param block archiveArray  archiveDict
+(__kindof GArchiveModel *)archiveUpdateWithType:(ArchiveType)type withClass:(Class)classModel wtihBlock:(void (^)(__kindof GArchiveModel* modelSub))block;




/// 插入数据
/// @param model 数据类型，需要继承GArchiveModel且实现DBMangerProtocol协议
+(void)insertWithModel:(GArchiveModel*)model;
/// 批量插入数据
+(void)insertWithModels:(NSArray<GArchiveModel*>*)models;

/// 删除数据
/// model需要包涵主键
/// @param strID 或者根据id删除数据
+(void)delWithModel:(GArchiveModel*)model withORID:(NSString*)strID;
/// 更新数据
+(void)updateWithModel:(GArchiveModel*)model;

 /// 查询所有数据
+(NSArray<GArchiveModel*>*)queryFromTableWithMarkClass:(Class)class;

 /// 根据id查询批量数据
+(NSArray<GArchiveModel*>*)queryFromTableWithIDArray:(NSArray<NSString*>*)idArray withMarkClass:(Class)class;

/// 是否已经储存过了
+(BOOL)isContainsWith:(GArchiveModel*)model;

///多个表切换的时候
+(void)dbTableChangeBLock:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
