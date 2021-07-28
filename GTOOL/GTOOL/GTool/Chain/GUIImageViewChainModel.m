//
//  GUIImageViewChainModel.m
//  GKitTool
//
//  Created by 邓志坚 on 2020/3/28.
//  Copyright © 2020 kapokcloud. All rights reserved.
//

#import "GUIImageViewChainModel.h"
#import <objc/runtime.h>

#define  G_CHAIN_IMAGEVIEW_IMPLEMENTATION(methodName, viewMethod, ParmaType)  G_CHAIN_IMPLEMENTATION(methodName, viewMethod, ParmaType, GUIImageViewChainModel * , UIImageView)
@implementation GUIImageViewChainModel

G_CHAIN_IMAGEVIEW_IMPLEMENTATION(image, setImage, UIImage *);
G_CHAIN_IMAGEVIEW_IMPLEMENTATION(highlightedImage, setHighlightedImage, UIImage *);
G_CHAIN_IMAGEVIEW_IMPLEMENTATION(highlighted, setHighlighted, BOOL);


@end



@implementation UIImageView (GChain)

- (GUIImageViewChainModel *)g_chain{
    
    GUIImageViewChainModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {

        NSAssert(![self isKindOfClass:[GUIImageViewChainModel class]], @"类型错误");

        model = [GUIImageViewChainModel new];
        model.view = self;
        objc_setAssociatedObject(self, _cmd, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
    }
    return model;
}

+(UIImageView*)g_Init:(void (^)(UIImageView* gs))initBlock{
    UIImageView* imageView = [[UIImageView alloc]init];
    if (initBlock) {
        initBlock(imageView);
    }
    return imageView;
}

+(UIImageView*)g_Init:(void (^)(UIImageView* gs))initBlock withSuperView:(UIView*)superView withMasonry:(void (^)(MASConstraintMaker *make,UIImageView* gs))masBlock{
    UIImageView* imageView = [UIImageView g_Init:initBlock];
    [superView addSubview:imageView];
    if (masBlock) {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            masBlock(make,imageView);
        }];
    }
    return imageView;
}
@end
