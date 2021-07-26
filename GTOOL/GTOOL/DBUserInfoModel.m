//
//  DBUserInfoModel.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "DBUserInfoModel.h"
#import "SecondModel.h"
@implementation DBUserInfoModel
-(NSString*)g_setDBTableNameMarker{

    return @"DBUserInfoModel_Name";
}
-(Class)g_setDBClassModelMarker{
    return  [SecondModel class];
}
-(NSArray<NSString*>*)g_setDBExcludedProperties{
    return @[@"aaa",@"userID"];
}
-(NSString*)g_setDBQueryMarker{
    return @"userID";
}
@end
