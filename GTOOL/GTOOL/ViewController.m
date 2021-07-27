//
//  ViewController.m
//  GTOOL
//
//  Created by tg on 2020/12/15.
//

#import "ViewController.h"
#import "SecondModel.h"
#import "SecondViewController.h"
#import "NSObject+swizzle.h"
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
}
- (IBAction)manonry:(id)sender {
    
    [UIView overrideMethod:@selector(mas_makeConstraints:) withMethod:@selector(mas_makeConstraints_lastView)];

    UILabel* label =  [UILabel g_Init:^(UILabel * _Nonnull gs) {
        gs.g_chain.backgroundColor(kOrangeColor);
    } withSuperView:self.view withMasonry:^(MASConstraintMaker * _Nonnull make, UILabel * _Nonnull gs) {
        make.left.top.offset(200);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    UILabel* label1 =  [UILabel g_copyView:label];
    [self.view addSubview:label1];

    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kMasLastView().mas_right).offset(20);
        make.top.equalTo(label);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    [UIImageView g_Init:^(UIImageView * _Nonnull gs) {
        gs.g_chain.backgroundColor(kRedColor).cornerRadius(100).shadowColor(kYellowColor.CGColor).shadowOffset(CGSizeMake(-3, 3)).shadowOpacity(1);
        gs.g_chain.borderColor([UIColor greenColor].CGColor).borderWidth(5);
    } withSuperView:self.view withMasonry:^(MASConstraintMaker * _Nonnull make, UIImageView * _Nonnull gs) {
        make.top.equalTo(kMasLastView().mas_bottom).offset(100);
        make.centerX.equalTo(kMasLastView());
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    
    
  
    
}
@end
