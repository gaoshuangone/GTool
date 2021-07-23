//
//  GDBManger.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "GDBManger.h"
#import "YIIFMDB.h"
#import "NSObject+GObject.h"
#import "GArchiveModel.h"
#define kUserDefaultsKey(keyString) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",keyString]]

#define DBKEY @"DBKEY"
static YIIFMDB *_dbShard = nil;

@interface GDBManger()
@property (strong, nonatomic)Class dbModelClass;
@end

@implementation GDBManger
GHELPER_SHARED(GDBManger)
+(GArchiveModel*)archiveGetWithType:(ArchiveType)type{
    
    NSString* key =[DBKEY stringByAppendingFormat:@"_%ld",(long)type];
    id  data  = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserDefaultsKey(key)];
    return data;

}
+(void)archiveDelWithType:(ArchiveType)type{
    NSError* error = [[NSError alloc]init];
    NSString* key =[DBKEY stringByAppendingFormat:@"_%ld",(long)type];
    [[NSFileManager defaultManager] removeItemAtPath:kUserDefaultsKey(key) error:&error];
    if (error.userInfo) {
//        NSLog(@"_NSKeyedArchiver删除数据失败");
    }

}
+(__kindof GArchiveModel *)archiveUpdateWithType:(ArchiveType)type withClass:(Class)dbModel wtihBlock:(void (^)(__kindof GArchiveModel* modelSub))block;{
    NSString* key =[DBKEY stringByAppendingFormat:@"_%ld",(long)type];

  id  data = [self archiveGetWithType:type];
    if (!data && dbModel) {
        data = [[dbModel alloc] init];
        GArchiveModel* model = data;
        model.archiveArray = @[].mutableCopy;
        model.archiveDict = @{}.mutableCopy;
    }

    if (block) {
        block(data);
    }
    NSError* error = [[NSError alloc]init];
    [[NSFileManager defaultManager] removeItemAtPath:kUserDefaultsKey(key) error:&error];
    if (!error) {
        
    }

    if (data) {
        BOOL isSuccces =   [NSKeyedArchiver archiveRootObject:data toFile:kUserDefaultsKey(key)];
        if (!isSuccces) {
            NSLog(@"%@_NSKeyedArchiver更新数据失败",dbModel);

        }
    }
    return data;
}




-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
-(YIIFMDB*)dbShard{
    
    if (!_dbShard) {
    
        
        _dbShard = [YIIFMDB shareDatabase];
        [_dbShard inDatabase:^{
            BOOL isSuccess =   [_dbShard createTableWithModelClass:[GDBManger shared].dbModelClass   excludedProperties:[[GDBManger shared].dbModelClass excludedProperties] tableName:[[GDBManger shared].dbModelClass getTableName]];
            if (!isSuccess) {
                
            }
        }];
    }
    return _dbShard;
}

+(void)insertWithModel:(GArchiveModel*)model{
    
    [GDBManger shared].dbModelClass = [model class];
    [[GDBManger shared].dbShard inTransaction:^(BOOL *rollback) {
        BOOL isSuccess = [[GDBManger shared].dbShard insertWithModel:model tableName:[[GDBManger shared].dbModelClass getTableName]];  //插入一条数据
        if (!isSuccess) {
            NSLog(@"******插入数据失败");
        }
        
    }];
    
    
}
+(void)insertWithModels:(NSArray<GArchiveModel*>*)models{
    
    if (kISEmpty(models)) {
        return;
    }
    
    GArchiveModel* model = models[0];
    [GDBManger shared].dbModelClass = [model class];

    [[GDBManger shared].dbShard inTransaction:^(BOOL *rollback) {
        
        
        [[GDBManger shared].dbShard insertWithModels:models tableName:[[GDBManger shared].dbModelClass getTableName]];  //插入一条数据
    }];
    
    
}

+(void)delWithModel:(GArchiveModel*)model withORID:(NSString*)strID;
{
    [GDBManger shared].dbModelClass = [model class];
    [[GDBManger shared].dbModelClass queryDBWeherMark];
    kWeakSelf
    [[GDBManger shared].dbShard inTransaction:^(BOOL *rollback) {
        
        YIIParameters* par = [[YIIParameters alloc]init];

        if (!kISEmpty([model valueForKey:[[GDBManger shared].dbModelClass queryDBWeherMark]])) {
            [weakSelf setYIIParameters:par withModel:model];

        }else if(strID){
            [weakSelf setYIIParameters:par withValue:strID];
        }else{
            NSAssert(0, @"chekcQueryDBWeherMark");
        }
      [[GDBManger shared].dbShard deleteFromTable:[[GDBManger shared].dbModelClass getTableName] whereParameters:par];  //插入一条数据
    
    }];
}
+(void)setYIIParameters:(YIIParameters*)par withValue:(id)value{
    [par orWhere:[[GDBManger shared].dbModelClass queryDBWeherMark] value:value relationType:YIIParametersRelationTypeLike];
}
+(void)setYIIParameters:(YIIParameters*)par withModel:(GArchiveModel*)model{
    [par orWhere:[[GDBManger shared].dbModelClass queryDBWeherMark] value:[model valueForKey:[[GDBManger shared].dbModelClass queryDBWeherMark]] relationType:YIIParametersRelationTypeLike];
}

+(NSArray<GArchiveModel*>*)queryFromTableWithMarkClass:(Class)class;
{
    __block NSArray* array  = nil;
    
    [[GDBManger shared].dbShard  inDatabase:^{
        
        array = [[GDBManger shared].dbShard queryFromTable:[[GDBManger shared].dbModelClass getTableName] model:class whereParameters:nil];
        NSLog(@"FMDB储存的数据为%@",array );
        
    }];
    return array;
    
}
+(NSArray<GArchiveModel*>*)queryFromTableWithIDArray:(NSArray<NSString*>*)idArray withMarkClass:(nonnull Class)class {
    [GDBManger shared].dbModelClass = class;
    
    __block NSArray* array  = nil;
    __block NSMutableArray* arrayTemp = @[].mutableCopy;
   NSMutableArray* arrayIDTemp = [NSMutableArray arrayWithArray:idArray];
    
    if (arrayIDTemp.count==0) {
        return arrayTemp;
    }
        YIIParameters* par = [[YIIParameters alloc]init];
        for (NSString* strId in arrayIDTemp) {
            [self setYIIParameters:par withValue:strId];
        }
       [[GDBManger shared].dbShard  inDatabase:^{
        array = [[GDBManger shared].dbShard queryFromTable:[[GDBManger shared].dbModelClass getTableName] model:[[GDBManger shared].dbModelClass class] whereParameters:par];
           [arrayTemp addObjectsFromArray:array];
        }];
        NSLog(@"FMDB储存的数据为%@",array );
        

    return arrayTemp;
    
}

+(void)updateWithModel:(GArchiveModel*)model{
    
    [GDBManger shared].dbModelClass = [model class];

    if (![self isContainsWith:model]) {
        [self insertWithModel:model];
        return;
    }else{
        YIIParameters* parameters = [[YIIParameters alloc]init];
        [self setYIIParameters:parameters withModel:model];
     
        [[GDBManger shared].dbShard deleteFromTable:[[GDBManger shared].dbModelClass getTableName] whereParameters:parameters];

        [[GDBManger shared].dbShard inDatabase:^{
            [self insertWithModel:model];
        }];
        

       
        
    }
    
    

//    YIIParameters* parameters = [[YIIParameters alloc]init];
//    [parameters andWhere:@"userIDString" value:model.userIDString relationType:YIIParametersRelationTypeEqualTo];
//    [[GDBManger shared].dbShard inTransaction:^(BOOL *rollback) {
//        [[GDBManger shared].dbShard updateTable:[self getTableName] dictionary:@{@"friend_type": @(model.friend_type)} whereParameters:parameters];
//    }];
    
    
    //    [[GDBManger shared].dbShard updateTable:TABLENAME dictionary:@{@"userId": @"123123"} whereParameters:parameters];
    //     BOOL aaa =  [[GDBManger shared].dbShard updateTable:TABLENAME dictionary:@{@"friend_type": @(5),@"userId": @"11111"} whereParameters:parameters];
    
    
    [self queryFromTableWithMarkClass:[GDBManger shared].dbModelClass];
}

+(BOOL)isContainsWith:(GArchiveModel*)model{
    
    [GDBManger shared].dbModelClass = [model class];

    YIIParameters *parameters = [[YIIParameters alloc] init];
    
    [self setYIIParameters:parameters withModel:model];
    __block NSInteger count = 0;
    [[GDBManger shared].dbShard  inDatabase:^{
        count =  [[GDBManger shared].dbShard numberOfItemsFromTable:[[GDBManger shared].dbModelClass getTableName] whereParameters:parameters];
        
    }];
    if (count !=0) {
        return YES;
    }
    
    return NO;
    
}
+(void)dbTableChangeBLock:(void (^)(void))block{
    _dbShard = nil;
    if (block) {
        block();
    }
}

@end
