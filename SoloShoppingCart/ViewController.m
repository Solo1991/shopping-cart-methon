//
//  ViewController.m
//  SoloShoppingCart
//
//  Created by Solo on 16/1/12.
//  Copyright © 2016年 Solo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Solo_Cart_Methon.h"
#define Screen_W    [UIScreen mainScreen].bounds.size.width
#define Screen_H    [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView          * SCtableview;
@property(nonatomic,strong)UIButton             * SCcart_btn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  initView];
}



-(void)initView
{
    [self.view addSubview:self.SCtableview];
    [self.view addSubview:self.SCcart_btn];
}

#pragma mark- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


static NSString * cellid  = @"cellid";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell    = [tableView dequeueReusableCellWithIdentifier:cellid];
    UIButton *btn;
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;
        cell.imageView.contentMode  = UIViewContentModeScaleAspectFit;
        cell.imageView.bounds       = CGRectMake(0, 0, 40, 40);

        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_W-100, 5, 90, 40)];
        [btn setTitle:@"添加到购物车" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor yellowColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn addTarget:self action:@selector(showAni:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    btn.tag = indexPath.row;
    
    
    if (indexPath.row%2)
    {
        cell.imageView.image = [UIImage imageNamed:@"Solo_1.jpg"];
    }else
    {
        cell.imageView.image = [UIImage imageNamed:@"Solo_2.jpg"];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)showAni:(UIButton*)sender
{
    
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:sender.tag inSection:0];

    [Solo_Cart_Methon startAnimationWithIndexPath:indexPath tableview:self.SCtableview end_view:self.SCcart_btn];
//    [Solo_Cart_Methon startAnimationWithRect:headRect
//                         ImageView:cell.imageView
//                      donghua_view:self.SCtableview
//                        super_view:self.view
//                         end_point:self.SCcart_btn.frame.origin
//                          end_view:self.SCcart_btn
//     ];
}


#pragma mark- lazy load
-(UITableView *)SCtableview
{
    if (!_SCtableview) {
        _SCtableview            = [[UITableView alloc]
                                   initWithFrame:CGRectMake(0, 50,Screen_W, Screen_H-50)
                                   style:UITableViewStylePlain];
        _SCtableview.delegate   = self;
        _SCtableview.dataSource = self;
        
    }
    return _SCtableview;
}

-(UIButton *)SCcart_btn
{
    if (!_SCcart_btn)
    {
        _SCcart_btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_W-46, 22, 20, 20)];
        [_SCcart_btn setImage:[UIImage imageNamed:@"Solo_good_cart_btn.png"] forState:UIControlStateNormal];
        _SCcart_btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _SCcart_btn;
}


@end
