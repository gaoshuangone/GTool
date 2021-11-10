//
//  ViewController.m
//  GTOOL
//
//  Created by tg on 2020/12/15.
//

#import "ViewController.h"
#import "SecondModel.h"
#import "NSObject+swizzle.h"
#import "LLDebugTool.h"
#import "HWProgressView.h"
#import "ExampleHistTestVC.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testArchiveModel;
@property (weak, nonatomic) IBOutlet UIButton *testSQLModel;
@property (weak, nonatomic) IBOutlet UIButton *testHitTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.view.backgroundColor = [UIColor whiteColor];
////
//    id aaa = @"";
//    NSLog(@"%@",[aaa stringValue]);
////
//    
//    NSMutableArray* array = @[].mutableCopy;
//    [array addObject:nil];
//  
//    
//    [self performSelector:@selector(ssss)];
    
    [self.getCurrentVC pushCanvas:@"ExampleHistTestVC"];

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
    
//    [UIView overrideMethod:@selector(mas_makeConstraints:) withMethod:@selector(mas_makeConstraints_lastView:)];

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

-(void)progress{
    //进度条
      HWProgressView *progressView = [[HWProgressView alloc] initWithFrame:CGRectMake(24, 141, kMainScreenWide()-48, 6)];
      //进度条边框宽度
      progressView.progerStokeWidth=0.01f;
      //进度条未加载背景
      progressView.progerssBackgroundColor=kColorStringHex(@"E1F5F2") ;
      //进度条已加载 颜色
      progressView.progerssColor=kColorStringHex(@"08C2A9");
      //背景边框颜色
      progressView.progerssStokeBackgroundColor=[UIColor clearColor];
      [self.view addSubview:progressView];
}
- (IBAction)ActionhitTest:(id)sender {
    [self.getCurrentVC pushCanvas:@"ExampleHistTestVC"];
    
}
@end
