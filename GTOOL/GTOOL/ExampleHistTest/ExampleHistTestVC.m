//
//  ExampleHistTestVC.m
//  GTOOL
//
//  Created by gaoshuang on 2021/11/10.
//

#import "ExampleHistTestVC.h"
#import "HistTestViewRed.h"
#import "HistTestViewOrange.h"
#import "HistTestViewYellow.h"
@interface ExampleHistTestVC ()
@property (strong, nonatomic)HistTestViewRed* viewRed;
@property (strong, nonatomic)HistTestViewOrange* viewOrange;
@property (strong, nonatomic)HistTestViewYellow* viewYelllo;


@end

@implementation ExampleHistTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewRed =[[HistTestViewRed alloc]init];
    _viewRed.g_chain.backgroundColor( kRedColor);
    [self.view addSubview:_viewRed];
    [_viewRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    
    _viewOrange =[[HistTestViewOrange alloc]init];

    _viewOrange.g_chain.backgroundColor( kOrangeColor);
    [_viewRed addSubview:_viewOrange];
    [_viewOrange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    
    _viewYelllo =[[HistTestViewYellow alloc]init];
    _viewYelllo.g_chain.backgroundColor( kYellowColor);
    [_viewRed addSubview:_viewYelllo];
    [_viewYelllo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.g_chain.title(@"click", 0).backgroundColor([UIColor purpleColor]);
    
    [_viewRed addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(280);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    _viewRed.userInteractionEnabled = YES;
    _viewYelllo.userInteractionEnabled = YES;
    _viewOrange.userInteractionEnabled = YES;

    // Do any additional setup after loading the view.
}
-(void)click{
    NSLog(@"button******click");
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
