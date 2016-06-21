//
//  HeLoginVC.m
//  kunyuan
//
//  Created by Tony on 16/6/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeLoginVC.h"
#import "HeEnrollVC.h"
#import "UIButton+Bootstrap.h"
#import "HeFindPasswordVC.h"

@interface HeLoginVC ()<UITextFieldDelegate>
@property(strong,nonatomic)IBOutlet UITextField *accountField;
@property(strong,nonatomic)IBOutlet UITextField *passwordField;
@property(strong,nonatomic)IBOutlet UIButton *loginButton;


@end

@implementation HeLoginVC
@synthesize accountField;
@synthesize passwordField;
@synthesize loginButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"坤元外卖";
        [label sizeToFit];
        self.title = @"登录";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)initializaiton
{
    [super initializaiton];
}

- (void)initView
{
    [super initView];
    UIBarButtonItem *enrollItem = [[UIBarButtonItem alloc] init];
    enrollItem.title = @"注册";
    enrollItem.tintColor = [UIColor whiteColor];
    enrollItem.target = self;
    enrollItem.action = @selector(enrollMethod:);
    self.navigationItem.rightBarButtonItem = enrollItem;
    
    [loginButton dangerStyle];
    loginButton.layer.borderWidth = 0;
    loginButton.layer.borderColor = [UIColor clearColor].CGColor;
    [loginButton setBackgroundImage:[Tool buttonImageFromColor:APPDEFAULTORANGE withImageSize:loginButton.frame.size] forState:UIControlStateNormal];
}

- (void)enrollMethod:(id)sender
{
    HeEnrollVC *enrollVC = [[HeEnrollVC alloc] init];
    enrollVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:enrollVC animated:YES];
}

- (IBAction)loginMethod:(id)sender
{

}

- (IBAction)findPassword:(id)sender
{
    HeFindPasswordVC *findPasswordVC = [[HeFindPasswordVC alloc] init];
    findPasswordVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:findPasswordVC animated:YES];
}

- (IBAction)quickLogin:(id)sender
{

}

- (IBAction)thirdPartyLogin:(UIButton *)sender
{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
