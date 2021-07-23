//
//  ThreeModel.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "ThreeModel.h"

@implementation ThreeModel
+(NSString*)g_setTableNameMarker{

    return @"DBUserInfoModel_Name_ThreeModel";
}
+(Class)g_setClassModelMarker{
    return  [ThreeModel class];
}
+(NSArray<NSString*>*)g_excludedProperties{
    return @[@"aaa",@"userIDSString"];
}
+(NSString*)g_setDBQueryMarker{
    return @"userIDSString";
}
@end
