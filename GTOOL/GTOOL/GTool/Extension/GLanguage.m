//
//  GLanguage.m
//  GTOOL
//
//  Created by gaoshuang on 2021/7/28.
//

#import "GLanguage.h"

@implementation GLanguage
#pragma -mark 多语言

/// 获取手机原始系统设置的语言
+(LanguageType)g_getString_localTyp{

    NSArray *languages = [NSLocale preferredLanguages];

         NSString *pfLanguageCode = [languages objectAtIndex:0];

    if ([pfLanguageCode hasPrefix:@"en"]) {
        return kLanguageType_English;
    }else if ([pfLanguageCode hasPrefix:@"zh"]
              || [pfLanguageCode hasPrefix:@"yue-Han"] ){
        if ([pfLanguageCode rangeOfString:@"Hans"].location != NSNotFound) {
            pfLanguageCode = @"zh-Hans"; // 简体中文
            
            return kLanguageType_Chinese_Simplified;
        } else { // zh-Hant\zh-HK\zh-TW
            pfLanguageCode = @"zh-Hant"; // 繁體中文
            return kLanguageType_Chinese_Traditional;
        }
    }
    return kLanguageType_System;
}

/// 获取app内设置的语言，在范围内没设置过就默认系统语言
+ (NSString *)g_getCurrentLanguageLproj {
    
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    if (!language) {
        LanguageType typeCurrentLocal = [GLanguage g_getString_localTyp];
        LanguageType typeSet = kLanguageType_System;;

        if (typeCurrentLocal == kLanguageType_Chinese_Simplified
            || typeCurrentLocal == kLanguageType_Chinese_Traditional) {//如果简体或者繁体就用手机设置语言
//            typeSet = kGSLanguageType_Chinese_Simplified;
            
             typeSet = typeCurrentLocal;
        }else if (typeCurrentLocal ==kLanguageType_English
                  ||typeCurrentLocal ==kLanguageType_ID){//如果是印尼或者英语就用手机设置语言
            typeSet = typeCurrentLocal;
        }else{//其它意外语言设置成英语
            typeSet = kLanguageType_English;
        }
       language =  [GLanguage g_setCurrentLanguage:typeSet];

    }
    return language;

}


+(BOOL)g_isChineseLanguage{

    if (([self g_getCurrentLanguageType] == kLanguageType_Chinese_Simplified)
        || ([self g_getCurrentLanguageType] == kLanguageType_Chinese_Traditional)) {
        return YES;
    }
    return NO;
}


//要跟创建的多语言文件 .lproj 一一对应
#define LANGUAGE_ZH  @"zh-Hans"
#define LANGUAGE_zh_HK  @"zh-HK"
#define LANGUAGE_EN  @"en"
#define LANGUAGE_ID  @"id"

/// /// 设置当前App内设置的语言转换类型
+ (LanguageType )g_getCurrentLanguageType{
    NSString*  language = [self g_getCurrentLanguageLproj];

    if ([language isEqualToString:LANGUAGE_ZH]) {
        return  kLanguageType_Chinese_Simplified;
    }else if ([language isEqualToString:LANGUAGE_zh_HK]){
        return  kLanguageType_Chinese_Traditional;
    }else if([language isEqualToString:LANGUAGE_EN]){
        return  kLanguageType_English;
    }else if([language isEqualToString:LANGUAGE_ID]){
        return  kLanguageType_ID;
    }
  return kLanguageType_System;
    
}
/// /// 设置当前语言模式并返回使用的多语言文件.lproj
+ (NSString *)g_setCurrentLanguage:(LanguageType)type {
    NSString* str =@"";//要跟创建的多语言文件 .lproj 一一对应
    if (type == kLanguageType_Chinese_Simplified) {
        str =LANGUAGE_ZH;
    }else if(type == kLanguageType_Chinese_Traditional){
        str =LANGUAGE_zh_HK;
    }else if(type == kLanguageType_English){
        str =LANGUAGE_EN;
    }else if(type == kLanguageType_ID){
        str =LANGUAGE_ID;
    }else{
        str =LANGUAGE_ZH;
    }
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"appLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  return str;
    
}

+(NSBundle*)g_getCurrentLanguageBundle{
        NSString*  language = [GLanguage g_getCurrentLanguageLproj];
       NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
       return [NSBundle bundleWithPath:path];
}
///// 初始化App当前语言/// 获取app设置的 .lproj名字  ，在许可范围内设置用系统语言代替，自定义bundle中使用
+ (NSString *)g_getCurrentLanguageBundleWithName:(NSString*)name withType:(NSString*)type{
    
    NSString*  language = [self g_getCurrentLanguageLproj];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];//获取自定义的bundlepath
    
    NSBundle *customBundle = [NSBundle bundleWithPath:path];//获取自定义的bundle
    
    NSString *languagePath = [customBundle pathForResource:language ofType:@"lproj"];//获取自定义的bundle下的文件路径
    
    //     NSLog(@"bundle55 = %@",[NSBundle bundleWithPath:languagePath].bundlePath);
    //    languagePath也可以直接拼接
    return [NSBundle bundleWithPath:languagePath].bundlePath;//获取自定义的bundle下的文件路径的bundle
    
}
@end
