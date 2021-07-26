//
//  ViewController.m
//  GTOOL
//
//  Created by tg on 2020/12/15.
//

#import "ViewController.h"
#import "SecondModel.h"
#import "SecondViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testArchiveModel;
@property (weak, nonatomic) IBOutlet UIButton *testSQLModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    UIButton* button = [UIButton g_Init:^(UIButton * _Nonnull gs) {
//        gs.g_chain.backgroundColor(kRedColor);
//    } withSuperView:self.view withMasonry:^(MASConstraintMaker * _Nonnull make, UIButton * _Nonnull gs) {
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.left.top.offset(100);
//    } withAction:^(UIButton * _Nonnull gs) {
//        SecondViewController* vc = [[SecondViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }];
//
//
//
//
//    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:button];
//    UIButton* button2 =  [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
//    [self.view addSubview:button2];
//    [button2 mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.left.top.offset(300);
//    }];
//
    // Do any additional setup after loading the view.
}


- (IBAction)archiveButton:(id)sender {
    SecondModel* model =  [SecondModel g_archiveWithBlock:^(__kindof GModel *modelSub) {
        [SecondModel g_archiveDel];

    }];

}
- (IBAction)sqlArchiveButton:(id)sender {
    //    DBUserInfoModel* db = [[DBUserInfoModel alloc]init];
    //
    //
    SecondModel* model1 = [[SecondModel alloc]init];
    model1.userID = @"11111";
    model1.aaa = @"bbb";
    
    //插入
    [model1 g_dbInsert];
    //查询所有
    [SecondModel g_dbQueryAll];
    //删除表
    [model1 g_dbDel];
    //插入
    [model1 g_dbInsert];
    model1.userID = @"2222";
    //插入
    [model1 g_dbInsert];
    //查询所有
    [SecondModel g_dbQueryAll];

    [model1 g_dbDelwithORQueryID:@"11111"];
    //查询所有
    [SecondModel g_dbQueryAll];
//        [GModelManger insertWithModel:model1];
//        [GModelManger queryFromTableWithMarkClass:[SecondModel class]];
//        [GModelManger delWithModel:nil withORID:@"11111"];
        
    //    [db insertWithModel:model1];
    //
    //
    //
    //    GModelManger* db = [GModelManger shared];

    //    SecondModel* model2 = [[SecondModel alloc]init];
    //    model2.userID = @"2222";
    //    model2.aaa = @"2222";
    //
    //    [db insertWithModel:model2];
    //
    //
    //    SecondModel* model3 = [[SecondModel alloc]init];
    //    model3.userID = @"33333";
    //    model3.aaa = @"33333";
    //
    //    [db insertWithModel:model3];
        
        
    //    SecondModel* model4 = [[SecondModel alloc]init];
    //    model4.userID = @"33333";
    //    model4.aaa = @"444444";
    //    [db updateWithModel:model4];
        
        
    //    [db delWithModel:model2 withORID:nil];
        
    //    [db queryFromTableWithMarkClass:[SecondModel class]];
        
        
        
        
    //    ThreeModel* model2 = [[ThreeModel alloc]init];
    //    model2.userIDSString = @"2222";
    //    [model2 dbInsert ];
    //
    //    [model2 queryFromTable];
    //    [model2 dbDel];
    //    [model2 queryFromTable];
    //    [model2 dbInsert ];
    //    [model2 queryFromTable];
    //    [ThreeModel dbDelwithID:@"2222"];
    //    [model2 queryFromTable];

    //    [db insertWithModel:model2];
    //
    //
    //    ThreeModel* model3 = [[ThreeModel alloc]init];
    //    model3.userIDSString = @"33333";
    //    model3.aaa = @"33333";
    //
    //    [db insertWithModel:model3];
    //
    //    [db queryFromTableWithMarkClass:[ThreeModel class]];
    }
@end
