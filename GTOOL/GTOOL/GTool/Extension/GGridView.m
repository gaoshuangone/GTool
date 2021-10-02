//
//  GGridView.m
//  LiveTool
//
//  Created by tg on 2021/4/16.
//

#import "GGridView.h"
@interface GGridView()
@property(assign, nonatomic)UIEdgeInsets insets;//控件距离superView间距
@property(assign, nonatomic)MASAxisType typeAxis;//方向
@property(assign, nonatomic)CGFloat fixedSpacingX;//控件水平间隔
@property(assign, nonatomic)CGFloat fixedSpacingY;//控件竖直间隔
@property(assign, nonatomic)NSInteger itemCount;//item数量,
@property(assign, nonatomic)NSInteger maxItemCount;//最大item数量,超过回自动折行

@end
@implementation GGridView
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame withItemCount:(NSInteger)count withMaxItemCount:(NSInteger)countMax withSuperEdgeInsets:(UIEdgeInsets)insets withFixedSpacingX:(CGFloat)fixedSpacingX withFixedSpacingY:(CGFloat)fixedSpacingY withBlock:(void (^)(UIView*view))blockView{
    
    if (self = [super initWithFrame:frame]) {
        _itemCount = count;
        _insets= insets;
        _fixedSpacingX =fixedSpacingX;
        _fixedSpacingY = fixedSpacingY;
        _maxItemCount =countMax;
        [self upDataViewWith:blockView];
    }
    return self;
}

-(void)upDataViewWith:(void (^)(UIView*view))block{
    NSInteger itemCount = _itemCount;//最大图标数量
    NSInteger countMax = _maxItemCount;//横排最大图标数量
    if (itemCount < countMax && countMax !=0) {
        countMax = itemCount;
    }
    CGFloat disLeft = self.insets.left;//距离super_left边距
    CGFloat disRight = self.insets.right;//距离super_right边距
    CGFloat disTop = self.insets.top;//距离super_Top边距
    CGFloat disBottom = self.insets.bottom;//距离super_Top边距
    CGFloat spaceX = self.fixedSpacingX;//Item横向间距
    CGFloat spaceY = self.fixedSpacingY;//Item纵向间距
    
    
    CGFloat wide = (self.frameWidth-disLeft-disRight-(countMax-1)*spaceX)/countMax;//Item宽度
    CGFloat height = (self.frameHeight-disTop-disBottom-((NSInteger)(itemCount/countMax))*spaceY)/((NSInteger)(itemCount/countMax));//Item高度


    CGSize sizeItem = CGSizeMake(wide,height);
    

    for (int i = 0; i< itemCount; i++) {
        CGFloat X = disLeft+(wide+spaceX)*((NSInteger)(i%countMax));
        CGFloat Y = disTop+(height+spaceY)*((NSInteger)(i/countMax));

        UIView* view = [[UIView alloc]init];
        view.tag = i;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(X);
            make.top.equalTo(self).offset(Y);
            make.size.mas_equalTo(sizeItem);
        }];
        if (block) {
            block(view);
        }
        
        
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
