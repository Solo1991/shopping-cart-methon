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
@property(nonatomic,strong)NSMutableDictionary  * SCdict;
@property(nonatomic,strong)UIButton             * cart_btn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    [self.view addSubview:self.SCtableview];
    [self.view addSubview:self.cart_btn];
}

#pragma mark- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
        cell.imageView.bounds       = CGRectMake(0, 0, 70, 70);
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_W-100, 20, 50, 50)];
        [btn setTitle:@"Add" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showAni:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    btn.tag = indexPath.row;
    
    
    if (indexPath.row%2)
    {
        cell.imageView.image = [UIImage imageNamed:@"Solo_1.png"];
    }else
    {
        cell.imageView.image = [UIImage imageNamed:@"Solo_2.png"];
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
    UITableViewCell *cell = [self.SCtableview cellForRowAtIndexPath:indexPath];
    
    CGRect rect             =   [self.SCtableview rectForRowAtIndexPath:indexPath];
    rect.origin.y           =   rect.origin.y - [self.SCtableview contentOffset].y;
    CGRect  headRect        =   cell.imageView.frame;
    headRect.origin.y       =   rect.origin.y + headRect.origin.y;
    
    [Solo_Cart_Methon startAnimationWithRect:headRect
                         ImageView:cell.imageView
                      donghua_view:self.SCtableview
                        super_view:self.view
                         end_point:CGPointMake(Screen_W-46,22)
                          end_view:self.cart_btn
     ];
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

-(UIButton *)cart_btn
{
    if (!_cart_btn)
    {
        _cart_btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_W-46, 22, 36, 36)];
        [_cart_btn setImage:[UIImage imageNamed:@"Solo_good_cart_btn.png"] forState:UIControlStateNormal];
    }
    return _cart_btn;
}

-(NSMutableDictionary *)SCdict
{
    if (!_SCdict)
    {
        _SCdict = [ NSMutableDictionary new];
    }
    return _SCdict;
}
@end
