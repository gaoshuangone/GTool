//
//  SecondModel.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "SecondModel.h"

@implementation SecondModel
+(NSString*)g_setDBTableNameMarker{

    return @"DBUserInfoModel_Name";
}
+(Class)g_setDBClassModelMarker{
    return  [SecondModel class];
}
+(NSArray<NSString*>*)g_setDBExcludedProperties{
    return @[@"aaa",@"userID"];
}
+(NSString*)g_setDBQueryMarker{
    return @"userID";
}


+(NSString*)g_setArchiveMarker{
    return NSStringFromClass([self class]);
}
@end
