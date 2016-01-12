//
//  Solo_Cart_Methon.m
//  PBAShow
//
//  Created by Solo on 15/12/30.
//  Copyright © 2015年 PBA. All rights reserved.
//

#import "Solo_Cart_Methon.h"
#define Screen_W    [UIScreen mainScreen].bounds.size.width
#define Screen_H    [UIScreen mainScreen].bounds.size.height

@interface Solo_Cart_Methon()
{
    CALayer     *_layer;
}
@property(nonatomic,strong)CALayer *layer;
@property(nonatomic,strong)UIBezierPath *path;
@end
@implementation Solo_Cart_Methon

+(void)startAnimationWithRect:(CGRect)rect
                    ImageView:(UIImageView *)imageView
                 donghua_view:(UIView*)donghua_view
                   super_view:(UIView*)super_view
                    end_point:(CGPoint)end_point
{
    Solo_Cart_Methon *solo_cart_methon  = [Solo_Cart_Methon new];
    solo_cart_methon.donghua_view       = donghua_view;
    solo_cart_methon.super_view         = super_view;
    solo_cart_methon.end_point          = end_point;
    
    [solo_cart_methon startAnimationWithRect:rect ImageView:imageView];
}
-(void)startAnimationWithRect:(CGRect)rect
                    ImageView:(UIImageView *)imageView
{
    if (!_layer)
    {
        _layer = [CALayer layer];
        _layer.contents = (id)imageView.layer.contents;
        
        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.bounds = rect;
        [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
        _layer.masksToBounds = YES;
        // 导航64
        _layer.position = CGPointMake(imageView.center.x, CGRectGetMidY(rect)+64);
        
        
        [self.super_view.layer addSublayer:_layer];
        
        self.path = [UIBezierPath bezierPath];
        [self.path moveToPoint:_layer.position];
        
        [self.path addCurveToPoint:self.end_point
                     controlPoint1:CGPointMake(Screen_W/4,self.end_point.y+50)
                     controlPoint2:CGPointMake(self.end_point.x-50, self.end_point.y-50)];
        
    }
    [self groupAnimation];
}
-(void)groupAnimation
{
    self.donghua_view.userInteractionEnabled = NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration        = 0.2f;
    expandAnimation.fromValue       = [NSNumber numberWithFloat:1];
    expandAnimation.toValue         = [NSNumber numberWithFloat:0.8f];
    expandAnimation.timingFunction  =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime   = 0.2f;
    narrowAnimation.duration    = 0.5f;
    narrowAnimation.fromValue   = [NSNumber numberWithFloat:0.8f];
    narrowAnimation.toValue     = [NSNumber numberWithFloat:0.3f];
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.7;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"])
    {
        self.donghua_view.userInteractionEnabled = YES;
        [_layer removeFromSuperlayer];
        _layer = nil;
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [self.end_view.layer addAnimation:shakeAnimation forKey:nil];
    }
}

@end