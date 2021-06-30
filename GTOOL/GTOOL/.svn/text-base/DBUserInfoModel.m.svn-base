//
//  DBUserInfoModel.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "DBUserInfoModel.h"
#import "SecondModel.h"
@implementation DBUserInfoModel
-(NSString*)getTableName{

    return @"DBUserInfoModel_Name";
}
-(Class)getClassModel{
    return  [SecondModel class];
}
-(NSArray<NSString*>*)excludedProperties{
    return @[@"aaa",@"userID"];
}
-(NSString*)queryDBWeherMark{
    return @"userID";
}
@end
