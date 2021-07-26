//
//  NSDate+GDate.m
//  GTOOL
//
//  Created by tg on 2020/12/21.
//
#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

#define CALENDAR_CURRENT [NSCalendar currentCalendar]
#define CALENDAR_UNIT (\
NSCalendarUnitYear|\
NSCalendarUnitMonth |\
NSCalendarUnitWeekOfYear |\
NSCalendarUnitWeekOfMonth |\
NSCalendarUnitWeekdayOrdinal |\
NSCalendarUnitWeekday |\
NSCalendarUnitDay |\
NSCalendarUnitHour |\
NSCalendarUnitMinute)

#define COMPONENTS(date) [CALENDAR_CURRENT components:CALENDAR_UNIT fromDate:date]
#import "NSDate+GDate.h"

@implementation NSDate (GDate)
#pragma mark - Data component
-(NSInteger)year {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}


-(NSInteger)month {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

-(NSInteger)day {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}
- (NSInteger)hour{
    NSDateComponents *components = COMPONENTS(self);
    return components.hour;
}

- (NSInteger) minute{
    NSDateComponents *components = COMPONENTS(self);
    return components.minute;
}

- (NSInteger)seconds{
    NSDateComponents *components = COMPONENTS(self);
    return components.second;
}
- (NSInteger)daysFrom1970{
    return ([self timeIntervalSince1970]+28800)/D_DAY;
}

- (NSInteger)weeksFrom1970{
    return ([self timeIntervalSince1970]+28800)/D_WEEK;
}

- (BOOL)isToday{
    NSInteger dateInterval = [self daysFrom1970];
    NSInteger nowInterval = [[NSDate date] daysFrom1970];
    return dateInterval==nowInterval;
}

- (BOOL)isYesterday{
    NSInteger dateInterval = [self daysFrom1970];
    NSInteger nowInterval = [[NSDate date] daysFrom1970];
    return dateInterval==nowInterval-1;
}

- (BOOL)isTomorrow{
    NSInteger dateInterval = [self daysFrom1970];
    NSInteger nowInterval = [[NSDate date] daysFrom1970];
    return dateInterval==nowInterval+1;
}

- (BOOL)isThisWeek{
    NSInteger dateInterval = [self weeksFrom1970];
    NSInteger nowInterval = [[NSDate date] weeksFrom1970];
    return dateInterval==nowInterval;
}

- (BOOL)isLastWeek{
    NSInteger dateInterval = [self weeksFrom1970];
    NSInteger nowInterval = [[NSDate date] weeksFrom1970];
    return dateInterval==nowInterval-1;
}

- (BOOL)isNextWeek{
    NSInteger dateInterval = [self weeksFrom1970];
    NSInteger nowInterval = [[NSDate date] weeksFrom1970];
    return dateInterval==nowInterval+1;
}

- (BOOL)isThisMonth{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}

- (BOOL)isNextMonth{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    if (components1.year == components2.year+1 && components1.month==1 && components2.month==12) {
        return YES;
    }
    return ((components1.year == components2.year) &&
            (components1.month == components2.month + 1));
}

- (BOOL)isLastMonth{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    if (components1.year == components2.year-1 && components1.month==12 && components2.month==1) {
        return YES;
    }
    return ((components1.year == components2.year) &&
            (components1.month == components2.month - 1));
}

- (BOOL)isThisYear{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return (components1.year == (components2.year));
}

- (BOOL)isNextYear{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS([NSDate date]);;
    return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)date{
    return ([self earlierDate:date] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)date{
    return ([self laterDate:date] == self);
}

- (BOOL)isSameDayAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)isSameWeekAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return ((components1.year == components2.year) &&
            (components1.weekOfYear == components2.weekOfYear));
}

- (BOOL)isSameMonthAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}

- (BOOL)isSameYearAsDate:(NSDate *)date{
    NSDateComponents *components1 = COMPONENTS(self);
    NSDateComponents *components2 = COMPONENTS(date);
    return (components1.year == components2.year);
}


/* Date 转换 NSString (默认格式：@"yyyy-MM-dd HH:mm:ss")   */
+ (NSString *)getStringWithDate:(NSDate *)date {
    return [self getStringWithDate:date format:@"yyyy-MM-dd HH:mm:ss"];
}

+(NSString*)getStringtCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    return currentTimeString;
    
}
/* Date 转换 NSString (默认格式：自定义)  */
+ (NSString *)getStringWithDate:(NSDate *)date format:(NSString *)format {
    if (format == nil) format = @"yyyy-MM-dd HH:mm:ss";
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

/* NSString 转换 Date (默认格式：@"yyyy-MM-dd HH:mm:ss") */
+ (NSDate *)getDateWithString:(NSString *)string {
    return [self getDateWithString:string format:@"yyyy-MM-dd HH:mm:ss"];
}

/* NSString 转换 Date (默认格式：自定义)  */
+ (NSDate *)getDateWithString:(NSString *)string format:(NSString *)format; {
    if (format == nil) format = @"yyyy-MM-dd HH:mm:ss";
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];
}
+(NSString*)getDateForStringTime:(NSString*)stringTie
{
    NSDate* timeSp = [NSDate dateWithTimeIntervalSince1970:[stringTie intValue]];
    return  [self getStringWithDate:timeSp];
    
    
}
+(NSString*)getStringWithDateString:(NSString*)stringTie withFormat:(NSString*)format
{
    NSDate* timeSp = [self getDateWithString:stringTie];
    
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeSp];
    return currentDateStr;
    
}
+(NSString*)getStringWithTimeInterval:(NSTimeInterval)stringIntegerTie withFormat:(NSString*)format{
    NSDate* timeSp = [NSDate dateWithTimeIntervalSince1970:stringIntegerTie ];
    
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeSp];
    return currentDateStr;
    
}


/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)getTimeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [NSDate getTimeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)getTimeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}



@end
