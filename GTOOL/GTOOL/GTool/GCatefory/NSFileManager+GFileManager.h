//
//  NSFileManager+GFileManager.h
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (GFileManager)

/**
 文件是否存在
 */
+ (BOOL)isExsitWithFilePath:(NSString *)filePath;

/**
 创建文件
 */
+ (BOOL)createFile:(NSString *)filePath deleteOld:(BOOL)flag;

/**
 删除文件
 */
+ (BOOL)deleteFile:(NSString *)filePath;
/**
 
 */
//文件大小
+ (long long)getFileSizeWithUrl:(NSURL *)fileUrl;
/**
 
 */
//媒体时长
+ (NSTimeInterval)getAvDurationWithUrl:(NSURL *)fileUrl;
/**
 
 */
//获取目录下所有的文件名
+(NSArray*)getListNameWithFilePath:(NSString *)filePath;
/**
 
 */
+(NSString*)getFilePath:(NSString*)pathString;
/**
 
 */
//文件名，带后缀
//lastPathComponent

//获取目录文件
+(NSMutableArray*)getListFilesAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
