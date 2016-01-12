//
//  Solo_Cart_Methon.h
//  PBAShow
//
//  Created by Solo on 15/12/30.
//  Copyright © 2015年 PBA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Solo_Cart_Methon : NSObject

@property(nonatomic,strong)UIView  *super_view;
@property(nonatomic,strong)UIView  *donghua_view;
@property(nonatomic,strong)UIView  *end_view;
@property(nonatomic)CGPoint end_point;




+(void)startAnimationWithRect:(CGRect)rect
                    ImageView:(UIImageView *)imageView
                 donghua_view:(UIView*)donghua_view
                   super_view:(UIView*)super_view
                    end_point:(CGPoint)end_point;
@end
