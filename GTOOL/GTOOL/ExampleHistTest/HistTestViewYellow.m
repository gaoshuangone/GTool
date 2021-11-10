//
//  HistTestViewYellow.m
//  GTOOL
//
//  Created by gaoshuang on 2021/11/10.
//

#import "HistTestViewYellow.h"

@implementation HistTestViewYellow
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"Yellow____%@",NSStringFromCGPoint(point));

    return [ super hitTest:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touc************Yellow");

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
