//
//  SecondViewController.m
//  GTOOL
//
//  Created by tg on 2020/12/16.
//
#import "SecondModel.h"
#import "SecondViewController.h"
#import "DBUserInfoModel.h"
#import "ThreeModel.h"

@interface SecondViewController ()

@property (strong, nonatomic)GCDTimer*  timerGCD;
@property (strong, nonatomic)NSTimer*  timer;

@end

static NSObject* model ;


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    [UIButton g_Init:^(UIButton * _Nonnull gs) {
        gs.g_chain.backgroundColor(kRedColor);
    } withSuperView:self.view withMasonry:^(MASConstraintMaker * _Nonnull make, UIButton * _Nonnull gs) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.top.offset(100);
    } withAction:^(UIButton * _Nonnull gs) {
        
//        [TLTimer cancelTask:weakSelf.durationTimerTask];
//        [weakSelf.timer destroy];
//        [weakSelf.timerGCD cancel];
//        [weakSelf.navigationController popViewControllerAnimated:YES];

    }];
    [self testDB];
//    [self testAlert];
//    [self testDate];
//    [self testGCD];

    [self testArchiveNew];

}
-(void)testDB{
//    DBUserInfoModel* db = [[DBUserInfoModel alloc]init];
//
//
    SecondModel* model1 = [[SecondModel alloc]init];
    model1.userID = @"11111";
    model1.aaa = @"11111";

    [GDBManger insertWithModel:model1];
    [GDBManger queryFromTableWithMarkClass:[SecondModel class]];
    [GDBManger delWithModel:nil withORID:@"11111"];
    
//    [db insertWithModel:model1];
//
//
//
//    GDBManger* db = [GDBManger shared];

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




-(void)testArchiveNew{
    
    SecondModel* model1 =   [GDBManger archiveGetWithClass:[SecondModel class]];
//
//    model1.userID = @"1111";
//
//    if (!model1) {
//        model1 = [[SecondModel alloc]init];
//    }
//    [GDBManger archiveSetWithModel:model1];
//
//    SecondModel* model2 =   [GDBManger archiveGetWithClass:[SecondModel class]];
//
//
//
//    SecondModel* model3 = [GDBManger archiveUpdateWithClass:[SecondModel class] wtihBlock:^(__kindof GModel * _Nonnull modelSub) {
//        SecondModel* model = modelSub;
//        model.userID = @"222222";
//    }];
    
//    ThreeModel* model4 = [GDBManger archiveUpdateWithClass:[ThreeModel class] wtihBlock:^(__kindof GModel * _Nonnull modelSub) {
//        ThreeModel* model = modelSub;
//        model.userID = @"222222";
//    }];
    
//    ThreeModel* model5= [GDBManger archiveWithClass:[ThreeModel class] wtihUpdateBlock:^(__kindof id<GDBMangerProtocol>  _Nonnull modelSub) {
//        ThreeModel* model = modelSub;
//        model.userID = @"555";
//    }];
    
//    ThreeModel* model4 = [GDBManger archiveWithClass:[ThreeModel class] wtihUpdateBlock:^(__kindof GModel * _Nonnull modelSub) {
//        ThreeModel* model = modelSub;
//        model.userID = @"4444";
//    }];
//
//    ThreeModel* model5 = [GDBManger archiveUpdateWithClass:[ThreeModel class] wtihBlock:^(__kindof GModel * _Nonnull modelSub) {
//        ThreeModel* model = modelSub;
//        model.userID = @"222222";
//    }];

}
-(void)testAlert{
    [UIAlertController alertAnimateViewWithTitle:@"aaa" message:@"dasfad" confirmTitle:@"qqq" handler:^{
            
    }];
    
    
}
-(void)testDate{
    NSLog(@"%d",[NSDate date].isToday);
}
-(void)testGCD{
//    _timerGCD= [[GCDTimer alloc]init];
//    [_timerGCD eventAutoTimesEvent:^(NSInteger times) {
//        NSLog(@"%ld",(long)times);
//
//    } completEvent:^{
//        NSLog(@"completEvent");
//
//    } timeIntervalWithSecs:1 withTimes:10 ];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sel) userInfo:nil repeats:YES];
}
-(void)sel{
   
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        // do something in main thread
        NSLog(@"sel--main thread");
    } else {
        // do something in other thread
        NSLog(@"sel--other thread");

    }
//    sleep(5);
}
-(void)dealloc{
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
