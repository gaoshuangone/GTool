//
//  DBMangerProtocol.h
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GArchiveModel;
/// 多张表需要多个模型，需要重新实现协议
@protocol GDBMangerProtocol <NSObject>
@optional
/// 生成表名 需要跟用户对应起来
+(NSString*)getTableName;
///根据表建立的模型
+(Class)getClassModel;
///筛选需要记录的表中的属性，为nil表示全部记录
+(NSArray<NSString*>*)excludedProperties;
///表中增删改查，需要的标示，表示要取GArchiveModel中一个属性来，多策略查询需要重新修改方法
+(NSString*)queryDBWeherMark;
//Archive中储存的标识符
+(NSString*)getArchiveMarker;


///父类赋值到子类，数据会被覆盖
-(void)convertForm:(GArchiveModel*)model;
@end

NS_ASSUME_NONNULL_END
