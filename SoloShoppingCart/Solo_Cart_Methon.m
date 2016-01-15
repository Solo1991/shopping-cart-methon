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
@property(nonatomic,strong)UIView  *super_view;
@property(nonatomic,strong)UIView  *tableview;
@property(nonatomic,strong)UIView  *end_view;
@property(nonatomic)       CGPoint end_point;
@property(nonatomic,strong)CALayer *layer;
@property(nonatomic,strong)UIBezierPath *path;
@end
@implementation Solo_Cart_Methon



+(void)startAnimationWithIndexPath:(NSIndexPath*)indexpath
                         tableview:(UITableView*)tableview
                          end_view:(UIView*)end_view
{
    UITableViewCell *cell   = [tableview cellForRowAtIndexPath:indexpath];
    CGRect rect             = [tableview rectForRowAtIndexPath:indexpath];
    rect.origin.y           =   rect.origin.y - [tableview contentOffset].y;
    CGRect  headRect        =   cell.imageView.frame;
    headRect.origin.y       =   rect.origin.y + headRect.origin.y;
    
    Solo_Cart_Methon *solo_cart_methon  = [Solo_Cart_Methon new];
    solo_cart_methon.tableview          = tableview;
    solo_cart_methon.end_view           = end_view;
    solo_cart_methon.super_view         = tableview.superview;
    solo_cart_methon.end_point          = end_view.center;
    
    [solo_cart_methon startAnimationWithRect:headRect ImageView:cell.imageView];
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
        _layer.position = CGPointMake(imageView.center.x, CGRectGetMidY(rect)+64);
        
        
        [self.super_view.layer addSublayer:_layer];
        
        self.path = [UIBezierPath bezierPath];
        [self.path moveToPoint:_layer.position];
        
        //  the track you can custom
        //  point-> point1 ->point2
        [self.path addCurveToPoint:self.end_point
                     controlPoint1:CGPointMake(Screen_W/4,self.end_point.y+50)
                     controlPoint2:CGPointMake(self.end_point.x-50, self.end_point.y-50)];
        
    }
    [self groupAnimation];
}
-(void)groupAnimation
{
    self.tableview.userInteractionEnabled = NO;
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
        self.tableview.userInteractionEnabled = YES;
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
