//
//  GLabelChainModel.m
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/27.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GLabelChainModel.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define  G_CHAIN_LABEL_IMPLEMENTATION(methodName, viewMethod, ParmaType)  G_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, GLabelChainModel * , UILabel)

@implementation GLabelChainModel

G_CHAIN_LABEL_IMPLEMENTATION(text, setText, NSString *);
G_CHAIN_LABEL_IMPLEMENTATION(font, setFont, UIFont *);
G_CHAIN_LABEL_IMPLEMENTATION(textColor, setTextColor, UIColor *);
G_CHAIN_LABEL_IMPLEMENTATION(attributedText, setAttributedText, NSAttributedString *);
G_CHAIN_LABEL_IMPLEMENTATION(textAlignment, setTextAlignment, NSTextAlignment);
G_CHAIN_LABEL_IMPLEMENTATION(numberOfLines, setNumberOfLines, NSInteger);
G_CHAIN_LABEL_IMPLEMENTATION(lineBreakMode, setLineBreakMode, NSLineBreakMode);
G_CHAIN_LABEL_IMPLEMENTATION(adjustsFontSizeToFitWidth, setAdjustsFontSizeToFitWidth, BOOL);
-(GLabelChainModel * _Nonnull (^)(NSString * _Nonnull))textLanguage{
    __weak typeof(self) weakSelf = self;
       return ^(NSString *text){
           return weakSelf.text(kLanguage(text));
       };
}
@end


@implementation UILabel (GChain)

- (GLabelChainModel *)g_chain{
    
    GLabelChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[GLabelChainModel class]], @"类型错误");

        model = [GLabelChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}
+(UILabel*)g_Init:(void (^)(UILabel* gs))initBlock{
    UILabel* label = [[UILabel alloc]init];
    if (initBlock) {
        initBlock(label);
    }
    return label;
}
+(UILabel*)g_Init:(void (^)(UILabel* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UILabel* gs))masBlock{
    UILabel* button = [UILabel g_Init:initBlock];
    [superView addSubview:button];
    if (masBlock) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            masBlock(make,button);
        }];
    }
    return button;
}
@end
