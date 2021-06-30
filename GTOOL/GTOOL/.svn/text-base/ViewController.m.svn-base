//
//  ViewController.m
//  GTOOL
//
//  Created by tg on 2020/12/15.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [UIButton g_Init:^(UIButton * _Nonnull gs) {
        gs.g_chain.backgroundColor(kRedColor);
    } withSuperView:self.view withMasonry:^(MASConstraintMaker * _Nonnull make, UIButton * _Nonnull gs) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.top.offset(100);
    } withAction:^(UIButton * _Nonnull gs) {
        SecondViewController* vc = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
  
    // Do any additional setup after loading the view.
}


@end
