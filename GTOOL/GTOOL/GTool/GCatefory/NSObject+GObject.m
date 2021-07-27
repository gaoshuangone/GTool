//
//  NSObject+GObject.m
//  GSLib_Example
//
//  Created by tg on 2020/12/14.
//  Copyright © 2020 xiamoweinuan. All rights reserved.
//

#import "NSObject+GObject.h"
@implementation NSObject (GObject)

UIColor* kColorStringHex(NSString*color){
    return kColorStringHexA(color, 1);
}
UIColor* kColorStringHexA(NSString*color,float a){
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:a];
}
UIColor* kColorHex(long long int hex){
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 \
    green:((float)((hex & 0xFF00) >> 8)) / 255.0 \
                             blue:((float)(hex & 0xFF)) / 255.0 alpha:1.0];
}

UIColor* kColorRGB(NSInteger r,NSInteger g,NSInteger b){
    return [UIColor colorWithRed:(r) / 255.0  \
                           green:(g) / 255.0  \
                           blue:(b) / 255.0  \
                           alpha:1];
}
UIColor* kColorRGBA(NSInteger r,NSInteger g,NSInteger b,float a){
    return [UIColor colorWithRed:(r) / 255.0  \
    green:(g) / 255.0  \
    blue:(b) / 255.0  \
                           alpha:(a)];
}
UIImage* kImageName(NSString*str){
    return [UIImage imageNamed:str];
}
UIImage* kImageFile(NSString* str){
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:str ofType:nil]];

}
BOOL kISEmpty(NSObject *obj){
    
    if (obj==nil) {
        return YES;
    }
    if (obj==NULL) {
        return YES;
    }
    if (obj==[NSNull new]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([(NSString*)obj length]==0 ) {
            return YES;
        }
        if ([[(NSString*)obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        }
        if([(NSString*)obj isEqualToString:@"(null)"]){
            return YES;
        }
        if ([(NSString*)obj isEqualToString:@"nullnull"]) {
            return YES;
        }
        NSString* objString = (NSString*)obj;
        
        if ([objString respondsToSelector:@selector(length)]) {
            return  objString.length <=0;
        }
    }
    if ([obj isKindOfClass:[NSData class]]) {
        return [((NSData *)obj) length]<=0;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)obj) count]<=0;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        return [((NSArray *)obj) count]<=0;
    }
    if ([obj isKindOfClass:[NSSet class]]) {
        return [((NSSet *)obj) count]<=0;
    }
    return NO;
}
CGFloat kMainScreenWide(void){
    return [UIScreen mainScreen].bounds.size.width;
}
CGFloat kMainScreenHeight(void){
    return [UIScreen mainScreen].bounds.size.height;

}
CGFloat kAdaptedWide(CGFloat wide){
    return ceilf(wide*kMainScreenWide()/375.0);
}
CGFloat kAdaptedHeight(CGFloat height){
    return ceilf(height*kMainScreenHeight()/667.0);

}
UIFont* kAdaptedFont(CGFloat fontSize){
    return  [UIFont systemFontOfSize:kAdaptedWide(fontSize)];
}
BOOL kIsIphoneX(void){
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

NSString* kStringSafe(NSObject* obj){
    if (!kISEmpty(obj)) {
        if ([(NSString*)obj isKindOfClass:[NSString class]]) {
            return [NSString stringWithFormat:@"%@", obj];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
           return [formatter stringFromNumber:(NSNumber*)obj];
        }
    }
    return @"";
    
}
UIViewController* kGetCurrentVC(void){
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    return kGetCurrentVCFrom(rootViewController);
}

UIViewController* kGetCurrentVCFrom(UIViewController *rootVC){
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC =kGetCurrentVCFrom([(UITabBarController *)rootVC selectedViewController]);
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC =kGetCurrentVCFrom([(UINavigationController *)rootVC visibleViewController])
        ;
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

- (UIViewController *)g_getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
UIView* kMasLastView(void){
    
   
    return [GSharedClass shared].masViewLast;
}
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
        LanguageType typeCurrentLocal = [NSObject g_getString_localTyp];
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
       language =  [NSObject g_setCurrentLanguage:typeSet];

    }
    return language;

}


+(BOOL)g_isChineseLanguage{

    if (([NSObject g_getCurrentLanguageType] == kLanguageType_Chinese_Simplified)
        || ([NSObject g_getCurrentLanguageType] == kLanguageType_Chinese_Traditional)) {
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
/// @param type
+ (LanguageType )g_getCurrentLanguageType{
    NSString*  language = [NSObject g_getCurrentLanguageLproj];

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
/// @param type
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
        NSString*  language = [NSObject g_getCurrentLanguageLproj];
       NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
       return [NSBundle bundleWithPath:path];
}
///// 初始化App当前语言/// 获取app设置的 .lproj名字  ，在许可范围内设置用系统语言代替，自定义bundle中使用
+ (NSString *)g_getCurrentLanguageBundleWithName:(NSString*)name withType:(NSString*)type{
    
    NSString*  language = [NSObject g_getCurrentLanguageLproj];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];//获取自定义的bundlepath
    
    NSBundle *customBundle = [NSBundle bundleWithPath:path];//获取自定义的bundle
    
    NSString *languagePath = [customBundle pathForResource:language ofType:@"lproj"];//获取自定义的bundle下的文件路径
    
    //     NSLog(@"bundle55 = %@",[NSBundle bundleWithPath:languagePath].bundlePath);
    //    languagePath也可以直接拼接
    return [NSBundle bundleWithPath:languagePath];//获取自定义的bundle下的文件路径的bundle
    
}

@end


@implementation GSharedClass
GHELPER_SHARED(GSharedClass)


@end
