//
//  HistTestViewRed.m
//  GTOOL
//
//  Created by gaoshuang on 2021/11/10.
//

#import "HistTestViewRed.h"
#import "HistTestViewOrange.h"
#import "ExampleHistTestVC.h"
@implementation HistTestViewRed
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"Red____%@",NSStringFromCGPoint(point));
    
    
    //系统默认会忽略isUserInteractionEnabled设置为NO、隐藏、alpha小于等于0.01的视图
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    
    //让button相应事件
    
    for (UIView* subview in [self.subviews reverseObjectEnumerator]) {
        
        if ([subview isKindOfClass:[UIButton class]]) {
            CGPoint buttonPoint = [self convertPoint:point toView:subview];
            
            //判断如果这个新的点是在中间按钮身上，那么处理点击事件最合适的view就是中间按钮
            if ( [subview pointInside:buttonPoint withEvent:event]) {
                return subview;
            }
            
            /*等价
             CGRect frame =subview.frame;
             UIView *vv = subview;
             while (vv.superview && ![vv.superview isKindOfClass:[HistTestViewRed class]]) {
             frame.origin.x += vv.frameX;
             frame.origin.y += vv.frameY;
             vv = vv.superview;
             }
             
             if (CGRectContainsPoint(frame, point)) {
             return subview;
             }
             */
            NSLog(@"Red___222_%@",NSStringFromCGPoint(buttonPoint));
            
            
        }
    }
    
    
    
    
    
    if ([self pointInside:point withEvent:event]) {//如果点击事件在自己内部
        
        
        
        
        
        //则从最上层的子视图开始
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            
            //转换坐标 等价
            //将point从fromview中转换到目标subview上，返回在目标subview的point
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            //将point从当前转换到目标subview上，返回目标的point
            //              CGPoint convertedPoint1 = [self convertPoint:point toView:subview];
            
            
            //还原坐标 等价
            //              CGPoint convertedPoint2 = [self convertPoint:convertedPoint1 fromView:subview];
            //                CGPoint convertedPoint3 = [subview convertPoint:convertedPoint1 toView:self];
            
            //如果有子试图命中测试
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        //如果子试图都没有命中，返回自己
        return self;
    }
    return [ super hitTest:point withEvent:event];
}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    return YES;
//}
//只有命中测试返回了自己才会执行touch方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touc************Red");
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
