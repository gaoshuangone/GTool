//
//  GLanguage.h
//  GTOOL
//
//  Created by gaoshuang on 2021/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,LanguageType){
    //跟随系统语言，默认
    kLanguageType_System,
     //简体中文
    kLanguageType_Chinese_Simplified,
    //繁体中文
    kLanguageType_Chinese_Traditional,
    //英文
    kLanguageType_English,
    //印尼
    kLanguageType_ID,
    
    //中文
//    kGSLanguageType_Chinese,
   
};
@interface GLanguage : NSObject
/**
 多语言适配
 */
/// 获取当前App内设置的语言
+ (LanguageType )g_getCurrentLanguageType;
/// 获取当前系统设置的语音
+(LanguageType)g_getString_localTyp;
/// 是否是中文
+(BOOL)g_isChineseLanguage;

/// 设置app语言模式并返回 .lproj 对应路径 ，可以不接受返回值
/// @param type type description
+ (NSString *)g_setCurrentLanguage:(LanguageType)type;

///// 初始化App当前语言 获取app设置的 .lproj 对应路径bundle ，在许可范围内用默认系统语言代替
+(NSBundle*)g_getCurrentLanguageBundle;

///// 初始化App当前语言/// 获取app设置的 .lproj名字  ，在许可范围内设置用系统语言代替，自定义bundle中使用
//+ (NSString *)g_getCurrentLanguageLprojWith;

///// 初始化App当前语言/// 获取app设置的 .lproj名字  ，在许可范围内设置用系统语言代替，自定义bundle中使用
+ (NSString *)g_getCurrentLanguageBundleWithName:(NSString*)name withType:(NSString*)type;
@end

NS_ASSUME_NONNULL_END
