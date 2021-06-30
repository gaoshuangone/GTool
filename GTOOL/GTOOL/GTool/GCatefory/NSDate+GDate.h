//
//  NSDate+GDate.h
//  GTOOL
//
//  Created by tg on 2020/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (GDate)

@property (readonly) NSInteger year;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger day;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;

// Comparing Dates
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;
- (BOOL)isSameDayAsDate:(NSDate *)date;
- (BOOL)isSameWeekAsDate:(NSDate *)date;
- (BOOL)isSameMonthAsDate:(NSDate *)date;
- (BOOL)isSameYearAsDate:(NSDate *)date;


/**
 获取当前时间(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+(NSString*)getStringtCurrentTimes;
/**
 Date 转换 NSString(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)getStringWithDate:(NSDate *)date;
/**
 Date 转换 NSString(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)getStringWithDate:(NSDate *)date format:(NSString *)format;
/**
  时间戳 转换 string(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+(NSString*)getStringWithTimeInterval:(NSTimeInterval)stringIntegerTie withFormat:(NSString*)format;
/**
 NSString格式的时间 转换  format自定义格式string(默认格式：@"yyyy-MM-dd HH:mm:ss")
 @return string
 */
+(NSString*)getStringWithDateString:(NSString*)stringTime withFormat:(NSString*)format;



/**
 NSString 转换 Date(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+ (NSDate *)getDateWithString:(NSString *)string;
/**
 字符串的时间 转换 Date(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+ (NSDate *)getDateWithString:(NSString *)string format:(NSString *)format;




/**
 计算上次日期距离现在多久
 
 @param lastTime    上次日期(需要和格式对应)
 @param format1     上次日期格式
 @param currentTime 最近日期(需要和格式对应)
 @param format2     最近日期格式
 @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)getTimeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;

/**
 计算上次日期距离现在多久
 
 @param lastTime    上次日期(需要和格式对应)
 @param currentTime 最近日期(需要和格式对应)
 * @return xx分钟前、xx小时前、xx天前
 */

+ (NSString *)getTimeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime;

@end

NS_ASSUME_NONNULL_END
