//
//  NSObject+GObject.m
//  GSLib_Example
//
//  Created by tg on 2020/12/14.
//  Copyright © 2020 xiamoweinuan. All rights reserved.
//

#import "NSObject+GObject.h"
#import "SVProgressHUD.h"
#import "GLanguage.h"
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
NSURL* kUrl(NSString* str){
    return [NSURL URLWithString:str];
}
BOOL kISNoEmpty(NSObject*obj){
    return !kISEmpty(obj);

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
BOOL kISIphoneX(void){
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

NSString* kLanguage(NSString* str){
    
//      return NSLocalizedStringFromTable(str, @"Localizable", nil);
    
    return  NSLocalizedStringFromTableInBundle(str, @"Localizable", [GLanguage g_getCurrentLanguageBundle], nil);
//    NSLocalizedString(key, comment)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:comment table:nil]
}

UIFont* kFontMedium(int fontSize){
    return [UIFont fontWithName:@"Roboto-Medium" size:fontSize];
}
UIFont* kFontRegular(int fontSize){
    return [UIFont fontWithName:@"Roboto-Regular" size:fontSize];
}
void kShowLoading(void){

    [SVProgressHUD  show];

}
void kHidLoading(void){
     [SVProgressHUD dismiss];

}
void kShowToast(NSString* str){
    kHidLoading();
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:str];
    [SVProgressHUD dismissWithDelay:1.2f];

}
void kShowLoadingWithText(NSString* str){
    kHidLoading();
    [SVProgressHUD showWithStatus:str];
}
void kUserDefaultSet(NSObject*obj,NSString*key){
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

id kUserDefaultGet(NSString*key){
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
UIView* kMasLastView(void){
    
   
    return [GSharedClass shared].masViewLast;
}

- (void)notificationObserve:(NSNotification *)notification{
    
}


@end


@implementation GSharedClass
GHELPER_SHARED(GSharedClass)


@end
