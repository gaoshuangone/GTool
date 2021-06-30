//
//  NSFileManager+GFileManager.m
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import "NSFileManager+GFileManager.h"
#import <AVFoundation/AVFoundation.h>
@interface FileProperty:NSObject
@property(strong,nonatomic) NSString *m_filename;
@property(strong,nonatomic) NSString *m_description;
@property(assign,nonatomic) UInt32  m_filesize;
@property(assign,nonatomic) UInt32  m_cluster;
@property(assign,nonatomic) UInt16  m_creatTime;
@property(assign,nonatomic) UInt16  m_creatDate;
@property(assign,nonatomic) UInt16  m_lastAccessDate;
@property(assign,nonatomic) UInt16  m_writeTime;
@property(assign,nonatomic) UInt16  m_writeDate;
@property(assign,nonatomic) UInt8   m_isDir;

@property(strong,nonatomic) NSString *m_ext_file_create_time;
@property(strong,nonatomic) NSString *m_ext_file_create_date;
@property(strong,nonatomic) NSString *m_ext_file_write_time;
@property(strong,nonatomic) NSString *m_ext_file_write_date;

@property(strong,nonatomic) NSString *m_ios_file_create_time;

@property(strong,nonatomic) NSString *m_ios_file_modified_time;

@property(strong,nonatomic) NSString *m_ext_file_path;

@end
@implementation FileProperty

@end


@implementation NSFileManager (GFileManager)
//文件是否存在
+ (BOOL)isExsitWithFilePath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

//创建文件
+ (BOOL)createFile:(NSString *)filePath deleteOld:(BOOL)flag{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return [manager createFileAtPath:filePath contents:nil attributes:nil];
    }else{
        if (flag) {
            if ([manager removeItemAtPath:filePath error:nil]) {
                return [manager createFileAtPath:filePath contents:nil attributes:nil];
            }else{
                return NO;
            }
        }else{
            return YES;
        }
    }
}

//删除文件
+ (BOOL)deleteFile:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return YES;
    }
    if ([manager removeItemAtPath:filePath error:nil]) {
        return YES;
    }
    return NO;
}

//文件大小
+ (long long)getFileSizeWithUrl:(NSURL *)fileUrl{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:fileUrl.filePathURL.path]){
        return [[manager attributesOfItemAtPath:fileUrl.filePathURL.path error:nil] fileSize];
    }
    return 0;
}

//媒体时长
+ (NSTimeInterval)getAvDurationWithUrl:(NSURL *)fileUrl{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@NO
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    
    //初始化媒体文件
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:fileUrl options:opts];
    
    //获取总时长,单位毫秒
    return  urlAsset.duration.value/urlAsset.duration.timescale*1000;
}
//测试数据
+(NSArray*)getListNameWithFilePath:(NSString *)filePath{
  
    NSFileManager* fm =[NSFileManager defaultManager];
    if([fm fileExistsAtPath:filePath]){
        //取得一个目录下得所有文件名
        NSArray *files = [fm subpathsAtPath: filePath ];
  
        return files;
        
    }
    return @[];
}
+(NSString*)getFilePath:(NSString*)pathString{
//    Documents/VIDEOTEMP
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:pathString];
    return path;
}


+(NSMutableArray*)getListFilesAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND");
    
    NSMutableArray *file_list = [[NSMutableArray alloc] init];
    int count;
    
    NSMutableArray *directoryContent = (NSMutableArray*)[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,[directoryContent objectAtIndex:count]];
        BOOL isDirectory;
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if(fileExistsAtPath == YES)
        {
            FileProperty *obj_de = [[FileProperty alloc] init];
            
            [obj_de setM_ios_file_create_time:attributes[NSFileCreationDate]];
            [obj_de setM_ios_file_modified_time:attributes[NSFileModificationDate]];
            [obj_de setM_filename:[directoryContent objectAtIndex:count]];
            [obj_de setM_filesize:(UInt32)[[attributes [NSFileSize] description] integerValue]];
            [obj_de setM_ext_file_path:path];//+
            if(isDirectory == YES)
                [obj_de setM_isDir:1];
            else
                [obj_de setM_isDir:0];
            [file_list addObject:obj_de];
        }
        
        NSLog(@"%@",attributes.description);
        
    }
    
    return file_list;
}

@end
