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

@interface NSObject (GObject)



// 强弱引用的self
#define kSelfWeak  __weak __typeof(self) selfWeak = self;
#define kSelfStrong __strong __typeof(selfWeak) selfStrong = selfWeak;
// 强弱引用的self对象。
#define kWeakObject(object) __weak __typedef(object) weakObject = object;
#define kStrongObject(object) __strong __typedef(weakObject) strongObject = weakObject;





#pragma mark - 通知
/**  通知  */
#define kNotiPost(nameStr,dic)  ({\
dispatch_async(dispatch_get_main_queue(), ^{\
        @try {\
            [[NSNotificationCenter defaultCenter] postNotificationName:name object:dict userInfo:nil];\
        }\
        @catch (NSException *exception) {}\
        @finally {}\
    });\
})
#define kNotiAddObserver(nameStr)  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationObserver:) name:nameStr object:nil];
#define kNotiRemove(nameStr) [[NSNotificationCenter defaultCenter]removeObserver:self name:nameStr object:nil];
#define kNotiRemoveAll(nameStr) [[NSNotificationCenter defaultCenter] removeObserver:self];

#pragma mark - 高度计算
#define kHeightStatusBar [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kHeightNavBar 44.0 //导航栏高度
#define kHeightTop (kHeightStatusBar + kHeightNavBar) //状态栏+导航栏 高度
#define kHeightTabBar (kHeightStatusBar>20?49+kHeightTabBarXPlus:49)//tabBar高度
#define kHeightTabBarXPlus (kISIphoneX()? 34:0)     //TabBar iPhoneX多余的高度
#define kHeightAvailable (kMainScreenWide() -kHeightTop - kHeightTabBar)




#ifdef DEBUG
#define NSLog(format, ...) do {      \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------------------------------------------------------\n"); \
} while (0)
#else
#define NSLog(...)
#endif




/**  颜色  */
#define kWhiteColor       [UIColor whiteColor]
#define kRedColor         [UIColor redColor]
#define kRedColor         [UIColor redColor]
#define kOrangeColor      [UIColor orangeColor]
#define kYellowColor      [UIColor yellowColor]

- (void)notificationObserve:(NSNotification *)notification;

UIColor* kColorStringHex(NSString*);
UIColor* kColorStringHexA(NSString*,float a);
UIColor* kColorHex(long long int);
UIColor* kColorRGB(NSInteger r,NSInteger g,NSInteger b);
UIColor* kColorRGBA(NSInteger r,NSInteger g,NSInteger b,float a);
/**
 高度计算
 */
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
