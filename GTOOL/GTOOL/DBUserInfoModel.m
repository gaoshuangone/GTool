//
//  DBUserInfoModel.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "DBUserInfoModel.h"
#import "SecondModel.h"
@implementation DBUserInfoModel
-(NSString*)g_setTableNameMarker{

    return @"DBUserInfoModel_Name";
}
-(Class)g_setClassModelMarker{
    return  [SecondModel class];
}
-(NSArray<NSString*>*)g_excludedProperties{
    return @[@"aaa",@"userID"];
}
-(NSString*)g_setDBQueryMarker{
    return @"userID";
}
@end
