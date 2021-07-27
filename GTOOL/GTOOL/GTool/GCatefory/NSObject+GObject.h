//
//  NSObject+GObject.h
//  GSLib_Example
//
//  Created by tg on 2020/12/14.
//  Copyright © 2020 xiamoweinuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



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
@interface NSObject (GObject)

// 获得弱引用对象
//#define kWeakObject(object) __weak __typeof(object) weakObject = object;

// 弱引用的对象。
//#define kWeak(caller, object) __weak __typeof(object) caller = object;
#define kWeakSelf __weak __typeof(self) weakSelf = self;

// 强引用对象。
//#define kStrongObject(object) __strong __typedef(object) strongObject = object;
#define kStrongSelf __strong __typedef(self) strongSelf = self;

/**  通知  */
#define kNotiPost(nameStr,dic)  [[NSNotificationCenter defaultCenter] postNotificationName:nameStr object:nil userInfo:dic];
#define kNotiObserver(nameStr,selString)  [[NSNotificationCenter defaultCenter]addObserver:self selector:(NSSelectorFromString(selString)) name:nameStr object:nil];
#define kNotiRemove(nameStr) [[NSNotificationCenter defaultCenter]removeObserver:self name:nameStr object:nil];

/**  高度计算  */
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavBarHeight 44.0 //导航栏高度
#define kTopHeight (kStatusBarHeight + kNavBarHeight) //状态栏+导航栏 高度

#define kTabBarXSurPlusHeigt  (kISIphoneX()? 34:0)     //TabBar iPhoneX多余的高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?49+kTabBarSurPlusHeigt:49)//tabBar高度

#define kAvailableHeight (SCREEN_HEIGHT -kTopHeight - kTabBarHeight)


/**  颜色  */
#define kWhiteColor       [UIColor whiteColor]
#define kRedColor         [UIColor redColor]
#define kRedColor         [UIColor redColor]
#define kOrangeColor      [UIColor orangeColor]
#define kYellowColor      [UIColor yellowColor]

UIColor* kColorStringHex(NSString*);
UIColor* kColorStringHexA(NSString*,float a);
UIColor* kColorHex(long long int);
UIColor* kColorRGB(NSInteger r,NSInteger g,NSInteger b);
UIColor* kColorRGBA(NSInteger r,NSInteger g,NSInteger b,float a);

UIImage* kImageName(NSString*);
UIImage* kImageFile(NSString*);
NSURL* kUrl(NSString* str);

BOOL kISEmpty(NSObject*);
BOOL kISNoEmpty(NSObject*);
BOOL kISIphoneX(void);


CGFloat kMainScreenWide(void);
CGFloat kMainScreenHeight(void);
CGFloat kAdaptedWide(CGFloat);
CGFloat kAdaptedHeight(CGFloat);

NSString* kStringSafe(NSObject*);

UIFont* kAdaptedFont(CGFloat);

UIViewController* kGetCurrentVC(void);

NSString* kLanguage(NSString* str);

UIFont* kFontMedium(int fontSize);
UIFont* kFontRegular(int fontSize);

void kShowLoading(void);
void kShowToast(NSString* str);
void kHidLoading(void);
void kShowLoadingWithText(NSString* str);

void kUserDefaultSet(NSObject*obj,NSString*key);
id kUserDefaultGet(NSString*key);

UIView* kMasLastView(void);

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


#define GHELPER_SHARED(CLASS)\
static CLASS *sharedHelper = nil;\
static dispatch_once_t predicate;\
+(instancetype)shared{ \
dispatch_once(&predicate, ^{\
sharedHelper = [[CLASS alloc] init];\
});\
return sharedHelper;} \

#define GHELPER_FREE()\
+(void)free{ \
sharedHelper = nil;\
predicate = 0l;\
}\

@protocol GHelperProtocol <NSObject>
/**
 单例统一接口协议
 
 @return self
 */
+(instancetype)shared;
@end



/// 第三方
@interface GSharedClass:NSObject<GHelperProtocol>
///保留masonry上一个试图
@property (strong, nonatomic)UIView* masViewLast;
/////GModel保存db，区分不同用户不同表
//@property (strong, nonatomic)NSString* modelDBMarker;
/////GModel保存归档，区分不同类型
//@property (strong, nonatomic)NSString* modelArchiveMarker;

@end

NS_ASSUME_NONNULL_END
