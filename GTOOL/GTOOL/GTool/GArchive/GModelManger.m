//
//  GModelManger.m
//  GTOOL
//
//  Created by tg on 2020/12/24.
//

#import "GModelManger.h"
#import "YIIFMDB.h"
#import "NSObject+GObject.h"
#import "GModel.h"
#define kUserDefaultsKey(keyString) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",keyString]]

#define DBKEY @"DBKEY"
static YIIFMDB *_dbShard = nil;

@interface GModelManger()
@property (strong, nonatomic)Class dbModelClass;
@end

@implementation GModelManger
GHELPER_SHARED(GModelManger)


+(NSString*)getArchiveKeyWithClass:(Class)classModel{
    return  [DBKEY stringByAppendingFormat:@"_%@",[classModel g_setArchiveMarker]];
    
}
+(GModel*)archiveGetWithClass:(Class)classModel{
    
    NSString* key =[self getArchiveKeyWithClass:classModel];
    id  data  = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserDefaultsKey(key)];
    
    if (!data && classModel) {
        data = [[classModel alloc] init];
        BOOL isSuccces =   [NSKeyedArchiver archiveRootObject:data toFile:kUserDefaultsKey(key)];
        if (!isSuccces) {
            NSLog(@"%@_NSKeyedArchiver更新数据失败",classModel);
        }
    }
    return data;

}


+(void)archiveDelWithClass:(Class)classModel{
    NSError* error = [[NSError alloc]init];
    NSString* key =[self getArchiveKeyWithClass:classModel];
    BOOL isSucccesRemove =   [[NSFileManager defaultManager] removeItemAtPath:kUserDefaultsKey(key) error:&error];
    if (!isSucccesRemove) {
        NSLog(@"_NSKeyedArchiver删除数据失败");
    }

}


/// 更新持久化数据
+(void)archiveUpdateWithClass:(Class)classModel with:(__kindof GModel*)model{
    NSString* key =[self getArchiveKeyWithClass:classModel];

    [GModelManger archiveDelWithClass:classModel];
    if (model) {
        BOOL isSuccces =   [NSKeyedArchiver archiveRootObject:model toFile:kUserDefaultsKey(key)];
        if (!isSuccces) {
            NSLog(@"%@_NSKeyedArchiver更新数据失败",classModel);

        }
    }
}



+(__kindof GModel *)archiveWithClass:(Class)classModel wtihBlock:(void (^)(__kindof GModel* modelSub))block{
    
    id  data = [self archiveGetWithClass:classModel];
    if (block) {
        block(data);
    }
    [GModelManger  archiveUpdateWithClass:classModel with:data];
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
            BOOL isSuccess =   [_dbShard createTableWithModelClass:[GModelManger shared].dbModelClass   g_excludedProperties:[[GModelManger shared].dbModelClass g_excludedProperties] tableName:[[GModelManger shared].dbModelClass g_setTableNameMarker]];
            if (!isSuccess) {
                
            }
        }];
    }
    return _dbShard;
}

+(void)insertWithModel:(GModel*)model{
    
    [GModelManger shared].dbModelClass = [model class];
    [[GModelManger shared].dbShard inTransaction:^(BOOL *rollback) {
        BOOL isSuccess = [[GModelManger shared].dbShard insertWithModel:model tableName:[[GModelManger shared].dbModelClass g_setTableNameMarker]];  //插入一条数据
        if (!isSuccess) {
            NSLog(@"******插入数据失败");
        }
        
    }];
    
    
}
+(void)insertWithModels:(NSArray<GModel*>*)models{
    
    if (kISEmpty(models)) {
        return;
    }
    
    GModel* model = models[0];
    [GModelManger shared].dbModelClass = [model class];

    [[GModelManger shared].dbShard inTransaction:^(BOOL *rollback) {
        
        
        [[GModelManger shared].dbShard insertWithModels:models tableName:[[GModelManger shared].dbModelClass g_setTableNameMarker]];  //插入一条数据
    }];
    
    
}

+(void)delWithModel:(GModel*)model withORID:(NSString*)strID;
{
    [GModelManger shared].dbModelClass = [model class];
    [[GModelManger shared].dbModelClass g_setDBQueryMarker];
    kWeakSelf
    [[GModelManger shared].dbShard inTransaction:^(BOOL *rollback) {
        
        YIIParameters* par = [[YIIParameters alloc]init];

        if (!kISEmpty([model valueForKey:[[GModelManger shared].dbModelClass g_setDBQueryMarker]])) {
            [weakSelf setYIIParameters:par withModel:model];

        }else if(strID){
            [weakSelf setYIIParameters:par withValue:strID];
        }else{
            NSAssert(0, @"chekcQueryDBWeherMark");
        }
      [[GModelManger shared].dbShard deleteFromTable:[[GModelManger shared].dbModelClass g_setTableNameMarker] whereParameters:par];  //插入一条数据
    
    }];
}
+(void)setYIIParameters:(YIIParameters*)par withValue:(id)value{
    [par orWhere:[[GModelManger shared].dbModelClass g_setDBQueryMarker] value:value relationType:YIIParametersRelationTypeLike];
}
+(void)setYIIParameters:(YIIParameters*)par withModel:(GModel*)model{
    [par orWhere:[[GModelManger shared].dbModelClass g_setDBQueryMarker] value:[model valueForKey:[[GModelManger shared].dbModelClass g_setDBQueryMarker]] relationType:YIIParametersRelationTypeLike];
}

+(NSArray<GModel*>*)queryFromTableWithMarkClass:(Class)class;
{
    __block NSArray* array  = nil;
    
    [[GModelManger shared].dbShard  inDatabase:^{
        
        array = [[GModelManger shared].dbShard queryFromTable:[[GModelManger shared].dbModelClass g_setTableNameMarker] model:class whereParameters:nil];
        NSLog(@"FMDB储存的数据为%@",array);
        
    }];
    return array;
    
}
+(NSArray<GModel*>*)queryFromTableWithIDArray:(NSArray<NSString*>*)idArray withMarkClass:(nonnull Class)class {
    [GModelManger shared].dbModelClass = class;
    
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
       [[GModelManger shared].dbShard  inDatabase:^{
        array = [[GModelManger shared].dbShard queryFromTable:[[GModelManger shared].dbModelClass g_setTableNameMarker] model:[[GModelManger shared].dbModelClass class] whereParameters:par];
           [arrayTemp addObjectsFromArray:array];
        }];
        NSLog(@"FMDB储存的数据为%@",array );
        

    return arrayTemp;
    
}

+(void)updateWithModel:(GModel*)model{
    
    [GModelManger shared].dbModelClass = [model class];

    if (![self isContainsWith:model]) {
        [self insertWithModel:model];
        return;
    }else{
        YIIParameters* parameters = [[YIIParameters alloc]init];
        [self setYIIParameters:parameters withModel:model];
     
        [[GModelManger shared].dbShard deleteFromTable:[[GModelManger shared].dbModelClass g_setTableNameMarker] whereParameters:parameters];

        [[GModelManger shared].dbShard inDatabase:^{
            [self insertWithModel:model];
        }];
        

       
        
    }
    
    

//    YIIParameters* parameters = [[YIIParameters alloc]init];
//    [parameters andWhere:@"userIDString" value:model.userIDString relationType:YIIParametersRelationTypeEqualTo];
//    [[GModelManger shared].dbShard inTransaction:^(BOOL *rollback) {
//        [[GModelManger shared].dbShard updateTable:[self g_setTableNameMarker] dictionary:@{@"friend_type": @(model.friend_type)} whereParameters:parameters];
//    }];
    
    
    //    [[GModelManger shared].dbShard updateTable:TABLENAME dictionary:@{@"userId": @"123123"} whereParameters:parameters];
    //     BOOL aaa =  [[GModelManger shared].dbShard updateTable:TABLENAME dictionary:@{@"friend_type": @(5),@"userId": @"11111"} whereParameters:parameters];
    
    
    [self queryFromTableWithMarkClass:[GModelManger shared].dbModelClass];
}

+(BOOL)isContainsWith:(GModel*)model{
    
    [GModelManger shared].dbModelClass = [model class];

    YIIParameters *parameters = [[YIIParameters alloc] init];
    
    [self setYIIParameters:parameters withModel:model];
    __block NSInteger count = 0;
    [[GModelManger shared].dbShard  inDatabase:^{
        count =  [[GModelManger shared].dbShard numberOfItemsFromTable:[[GModelManger shared].dbModelClass g_setTableNameMarker] whereParameters:parameters];
        
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
